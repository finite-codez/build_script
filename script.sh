#!/bin/bash
set -e

# ========== Colors ==========
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

function success() {
    echo -e "${GREEN}$1${NC}"
}

function error() {
    echo -e "${RED}$1${NC}"
}

# ========== Timer Start ==========
START_TIME=$(date +%s)

# ========== Logging ==========
LOGFILE=build.log
exec > >(tee -a "$LOGFILE") 2>&1

# ========== Cleanup ==========
rm -rf .repo/local_manifests/
success "Cleaned previous local_manifests"

# ========== Repo Init ==========
repo init --depth=1 --no-repo-verify -u https://github.com/finite-codez/fetch.git -b lineage-22.2 -g default,-mips,-darwin,-notdefault
success "Repo init success"

# ========== Local Manifest Clone ==========
git clone https://github.com/finite-codez/local_manifests_blossom.git -b lineage-22.2 .repo/local_manifests
success "Local manifest clone success"

# ========== Sync ==========
if [ ! -f /opt/crave/resync.sh ]; then
    error "Missing /opt/crave/resync.sh!"
    exit 1
fi

/opt/crave/resync.sh
success "Sync script executed"

# ========== Export User Info ==========
export BUILD_USERNAME=finitecode
export BUILD_HOSTNAME=crave
success "User/Host exported"

# ========== Build Environment Setup ==========
. build/envsetup.sh
success "Envsetup complete"

# ========== Build Start ==========
echo -e "${GREEN}====== Starting build for blossom (user), you may pray ======${NC}"

if command -v brunch &>/dev/null; then
    brunch blossom user
else
    error "brunch not found, falling back to lunch + make"
    lunch blossom
    make -j$(nproc) otapackage
fi

# ========== Timer End ==========
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))
success "✅ Build finished in $((DURATION / 60))m $((DURATION % 60))s"
