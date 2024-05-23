#!/bin/bash
############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "The script is for watch video from the server."
   echo
   echo "To Run script -> sh ./build_script.sh [OPTIONS]"
   echo "Syntax: scriptTemplate [-h|v]"
   echo "options:"
   echo "-h                 Print this Help."
   echo "-a                 enable to build Android - by default is true or enable."
   echo "-i                 enable to build iOS - by default is true or enable."
   echo "-e [argument]      to set environment for building the app. argument[prod , dev] -by default is p"
   echo "[prod]                production"
   echo "[dev]                development"
}

############################################################
############################################################
# Main program                                             #
############################################################
############################################################

# Set variables
enable_android=true
enable_ios=true
environment="prod"

############################################################
# Process the input options. Add options as needed.        #
############################################################
# Get the options
while getopts :ha:hi:he: flag
do
    case "${flag}" in
        h) 
            Help
            exit;;
        a) enable_android=${OPTARG};;
        i) enable_ios=${OPTARG};;
        e) environment=${OPTARG};;
    esac
done

echo "#Checking flutter version"
echo "-----------------------------------------------------------"
fvm flutter --version
echo "-----------------------------------------------------------"
echo "#Install all dependencies"
echo "-----------------------------------------------------------"
fvm flutter pub get 
fvm flutter packages pub get
echo "# Generate localization"
echo "-----------------------------------------------------------"
flutter pub run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart
echo "# Generate dependencies"
echo "-----------------------------------------------------------"
flutter pub run build_runner build --delete-conflicting-outputs
if [ "$enable_android" = true ]; then
    echo "-----------------------------------------------------------"
    echo "# Android building"
    
    if [ "$environment" = "prod" ]; then 
        echo "-----------------------------------------------------------"
        echo "#build appbundle prod"
        fvm flutter build appbundle -t lib/main.dart --release
    elif [ "$environment" = "dev" ]; then
        echo "-----------------------------------------------------------"
        echo "#build apk development"
        fvm flutter build apk -t lib/main_dev.dart --release
    else
        echo "-----------------------------------------------------------"
        echo "<$environment> command not found"
    fi
fi

# if [ "$enable_ios" = true ]; then
#     if [ "$environment" = "prod" ]; then
#         echo "-----------------------------------------------------------"
#         echo "#build appstore ipa"
#         echo "-----------------------------------------------------------"
#         fvm flutter build ipa -t lib/main.dart --release --export-options-plist=ios/export_options_appstore.plist
#     elif [ "$environment" = "dev" ]; then
#         echo "-----------------------------------------------------------"
#         echo "#build development adhoc ipa"
#         echo "-----------------------------------------------------------"
#         fvm flutter build ipa -t lib/main_dev.dart --release --export-options-plist=ios/export_options_adhoc.plist
#     else
#         echo "-----------------------------------------------------------"
#         echo "<$environment> command not found"
#     fi
# fi

echo "-----------------------------------------------------------"
echo "#Done"
echo "-----------------------------------------------------------"
