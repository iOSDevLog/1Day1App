# Sets the target folders and the final framework product.
# 如果工程名称和Framework的Target名称不一样的话，要自定义FRAMEWORK_NAME
# FRAMEWORK_NAME=${PROJECT_NAME}
SRCROOT=.
FRAMEWORK_NAME=RWUIControlsFramework
# Install dir will be the final output to the framework.
# The following line create it in the root folder of the current project.
INSTALL_DIR=${SRCROOT}/Products/${FRAMEWORK_NAME}.framework
# Working dir will be deleted after the framework creation.
WORKING_DIR=build
DEVICE_DIR=${WORKING_DIR}/Release-iphoneos/${FRAMEWORK_NAME}.framework
SIMULATOR_DIR=${WORKING_DIR}/Release-iphonesimulator/${FRAMEWORK_NAME}.framework
# -configuration ${CONFIGURATION}
# Clean and Building both architectures.
xcodebuild -configuration "Release" -target "${FRAMEWORK_NAME}" -sdk iphoneos clean build
xcodebuild -configuration "Release" -target "${FRAMEWORK_NAME}" -sdk iphonesimulator clean build
# Cleaning the oldest.
if [ -d "${INSTALL_DIR}" ]
then
    rm -rf "${INSTALL_DIR}"
fi
mkdir -p "${INSTALL_DIR}"
cp -R "${DEVICE_DIR}/" "${INSTALL_DIR}/"
# Uses the Lipo Tool to merge both binary files ([arm_v7] [i386] [x86_64] [arm64]) into one Universal final product.
lipo -create "${DEVICE_DIR}/${FRAMEWORK_NAME}" "${SIMULATOR_DIR}/${FRAMEWORK_NAME}" -output "${INSTALL_DIR}/${FRAMEWORK_NAME}"
rm -r "${WORKING_DIR}"
open "${INSTALL_DIR}"
