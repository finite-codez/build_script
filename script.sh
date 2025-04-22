rm -rf .repo/local_manifests/

#repo init
repo init --depth=1 --no-repo-verify -u https://github.com/crdroidandroid/android.git -b 15.0 -g default,-mips,-darwin,-notdefault
echo "=================="
echo "Repo init success"
echo "=================="

#local_manifest
git clone https://github.com/blazey66/local_manifest_clo.git -b vic .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

#Sync
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=Blazey66
export BUILD_HOSTNAME=crave
echo "======= Export Done ======"

# Set up build environment
. build/envsetup.sh
echo "====== Envsetup Done ======="

#Lunch
lunch lineage_mi439-userdebug
echo "============="

#Run to prepare our devices list
brunch mi439
