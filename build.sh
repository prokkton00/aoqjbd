#sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/IQ-7/manifest.git -b xq -g default,-mips,-darwin,-notdefault
git clone https://github.com/IQ-7/local_manifest --depth 1 -b xq-whyred .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source $CIRRUS_WORKING_DIR/script/config
timeStart

source build/envsetup.sh
export TZ=Asia/Jakarta
export BUILD_USERNAME=zacky
export BUILD_HOSTNAME=android-build
export ALLOW_MISSING_DEPENDENCIES=true
lunch xtended_whyred-userdebug
mkfifo reading
tee "${BUILDLOG}" < reading &
build_message "Building Started"
progress &
make xtended -j8  > reading

retVal=$?
timeEnd
statusBuild
