#!/bin/sh
# Eddytor CLI installer — detects OS/arch and downloads the latest release.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/eddytor-labs/eddytor-cli/main/install.sh | sh
#
# Environment variables:
#   EDDYTOR_INSTALL_DIR — installation directory (default: /usr/local/bin, or ~/.local/bin if no write access)
#   EDDYTOR_VERSION     — specific version to install (default: latest)

set -e

REPO="eddytor-labs/eddytor-cli"
BINARY="eddytor"

main() {
    # Detect OS
    OS="$(uname -s)"
    case "$OS" in
        Linux)  os="unknown-linux-gnu" ;;
        Darwin) os="apple-darwin" ;;
        *)      echo "Unsupported OS: $OS (use Windows Scoop instead)"; exit 1 ;;
    esac

    # Detect architecture
    ARCH="$(uname -m)"
    case "$ARCH" in
        x86_64|amd64)  arch="x86_64" ;;
        arm64|aarch64) arch="aarch64" ;;
        *)             echo "Unsupported architecture: $ARCH"; exit 1 ;;
    esac

    TARGET="${arch}-${os}"

    # Determine version
    if [ -n "$EDDYTOR_VERSION" ]; then
        VERSION="$EDDYTOR_VERSION"
    else
        VERSION=$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" \
            | grep '"tag_name"' | head -1 | sed 's/.*"v\(.*\)".*/\1/')
        if [ -z "$VERSION" ]; then
            echo "Failed to determine latest version. Set EDDYTOR_VERSION manually."
            exit 1
        fi
    fi

    # Determine install directory
    if [ -n "$EDDYTOR_INSTALL_DIR" ]; then
        INSTALL_DIR="$EDDYTOR_INSTALL_DIR"
    elif [ -w /usr/local/bin ]; then
        INSTALL_DIR="/usr/local/bin"
    else
        INSTALL_DIR="$HOME/.local/bin"
        mkdir -p "$INSTALL_DIR"
    fi

    ARCHIVE="${BINARY}-${VERSION}-${TARGET}.tar.gz"
    URL="https://github.com/${REPO}/releases/download/v${VERSION}/${ARCHIVE}"

    echo "Installing ${BINARY} v${VERSION} (${TARGET}) to ${INSTALL_DIR}..."

    # Download and extract
    TMPDIR=$(mktemp -d)
    trap 'rm -rf "$TMPDIR"' EXIT

    CHECKSUMS_URL="https://github.com/${REPO}/releases/download/v${VERSION}/checksums-sha256.txt"

    curl -fsSL "$URL" -o "${TMPDIR}/${ARCHIVE}"
    curl -fsSL "$CHECKSUMS_URL" -o "${TMPDIR}/checksums-sha256.txt"

    # Verify checksum
    EXPECTED=$(grep "${ARCHIVE}" "${TMPDIR}/checksums-sha256.txt" | cut -d' ' -f1)
    if [ -z "$EXPECTED" ]; then
        echo "No checksum found for ${ARCHIVE}. Aborting."
        exit 1
    fi
    ACTUAL=$(sha256sum "${TMPDIR}/${ARCHIVE}" 2>/dev/null || shasum -a 256 "${TMPDIR}/${ARCHIVE}")
    ACTUAL=$(echo "$ACTUAL" | cut -d' ' -f1)
    if [ "$EXPECTED" != "$ACTUAL" ]; then
        echo "Checksum mismatch! Expected ${EXPECTED}, got ${ACTUAL}. Aborting."
        exit 1
    fi

    tar xzf "${TMPDIR}/${ARCHIVE}" -C "$TMPDIR"
    install -m 755 "${TMPDIR}/${BINARY}-${VERSION}-${TARGET}/${BINARY}" "${INSTALL_DIR}/${BINARY}"

    echo "Installed ${BINARY} to ${INSTALL_DIR}/${BINARY}"

    # Check if install dir is in PATH
    case ":$PATH:" in
        *":${INSTALL_DIR}:"*) ;;
        *)
            echo ""
            echo "Add ${INSTALL_DIR} to your PATH:"
            echo "  export PATH=\"${INSTALL_DIR}:\$PATH\""
            ;;
    esac

    echo ""
    echo "Get started:"
    echo "  ${BINARY} login"
}

main
