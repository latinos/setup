if [ -z $CMSSW_BASE ]; then
    echo "======================================="
    echo "No CMS environment detected; stopping..."
    echo "======================================="
    exit 1
fi

source $CMSSW_BASE/src/LatinosSetup/Functions.sh

if [[ "$CMSSW_VERSION" == CMSSW_5_*_* ]]; then

    echo "======================================="
    echo "  running with $CMSSW_VERSION - this is an 8 TeV setup!"
    echo "  Current Time:" $(date)
    echo "  checking out additional repositories; this could take a while ..."
    echo "  Only shape analysis toolkit will be setup"
    echo "  Please use Setup.sh for the full package"
    echo "       export SCRAM_ARCH=slc5_amd64_gcc472"
    echo "======================================="

    echo " - Basic Code"

    github-addext latinos/HWWAnalysis.git HWWAnalysis

    github-addext latinos/HiggsAnalysis-CombinedLimit.git HiggsAnalysis/CombinedLimit HiggsAnalysis-CombinedLimit-V02-06-00


    echo "======================================="
    echo " ... Done.                             "
    echo "Current Time:" $(date)
    echo "======================================="

elif [[ "$CMSSW_VERSION" == CMSSW_7_*_* ]]; then

    echo "======================================="
    echo "  running with $CMSSW_VERSION - this is an 13 TeV setup!"
    echo "  Current Time:" $(date)
    echo "  checking out additional repositories; this could take a while ..."
    echo "  Only shape analysis toolkit will be setup"
    echo "  Please use Setup.sh for the full package"
    echo "       export SCRAM_ARCH=???"
    echo "======================================="

    echo " - Basic Code"

    github-addext latinos/LatinoAnalysis.git LatinoAnalysis

    echo " - Setup MELA"
    git clone git@github.com:cms-analysis/HiggsAnalysis-ZZMatrixElement.git ZZMatrixElement
    cd ZZMatrixElement
    echo " checking out MELA release v2.0.1 ..."
    git checkout tags/v2.0.1
    cd -
    echo " ...done."
    source ZZMatrixElement/setup.sh -j 12

    echo "======================================="
    echo " ... Done.                             "
    echo "Current Time:" $(date)
    echo "======================================="

elif [[ "$CMSSW_VERSION" == CMSSW_8_*_* ]]; then
    echo "======================================="
    echo "running with $CMSSW_VERSION - this is a 13 TeV setup!"
    echo "Current time:" $(date)
    echo "checking out additional repositories; this could take a while ..."
    echo "======================================="

    echo " - Basic Code"

    github-addext latinos/LatinoAnalysis.git LatinoAnalysis

    echo " - get recaster for MELA"
    git clone git@github.com:usarica/MelaAnalytics.git

    echo " - Setup MELA"
    git clone git@github.com:cms-analysis/HiggsAnalysis-ZZMatrixElement.git ZZMatrixElement
    cd ZZMatrixElement
    echo " checking out MELA release v2.1.1 ..."
    git checkout tags/v2.1.1
    cd -
    echo " ...done."
    source ZZMatrixElement/setup.sh -j 12

    echo " - Plotting Tools"

    git clone git@github.com:yiiyama/multidraw.git LatinoAnalysis/MultiDraw
    cd LatinoAnalysis/MultiDraw
    git checkout 2.0.12 2>/dev/null
    ./mkLinkDef.py --cmssw

elif [[ "$CMSSW_VERSION" == CMSSW_9_*_* ]]; then
    echo "======================================="
    echo "running with $CMSSW_VERSION - this is a 13 TeV setup!"
    echo "Current time:" $(date)
    echo "checking out additional repositories; this could take a while ..."
    echo "======================================="

    echo " - Basic Code"

    github-addext latinos/LatinoAnalysis.git LatinoAnalysis

    echo " - Nano Tools"

    git clone git@github.com:cms-nanoAOD/nanoAOD-tools.git PhysicsTools/NanoAODTools 

    echo " - Plotting Tools"

    git clone git@github.com:yiiyama/multidraw.git LatinoAnalysis/MultiDraw
    cd LatinoAnalysis/MultiDraw
    git checkout 2.0.8 2>/dev/null
    ./mkLinkDef.py --cmssw
    cd ../..

    echo " - MELA"

    git clone git@github.com:MELALabs/MelaAnalytics.git MelaAnalytics
    cd MelaAnalytics ; git checkout -b from-v21 v2.1 ; cd ..
    git clone https://github.com/cms-analysis/HiggsAnalysis-ZZMatrixElement.git ZZMatrixElement
    cd ZZMatrixElement ; git checkout -b from-v223 v2.2.3 ; source setup.sh -j 12 ; cd ..

elif [[ "$CMSSW_VERSION" == CMSSW_10_*_* ]]; then
    echo "======================================="
    echo "running with $CMSSW_VERSION - this is a 13 TeV setup!"
    echo "Current time:" $(date)
    echo "checking out additional repositories; this could take a while ..."
    echo "======================================="

    echo " - Basic Code"

    github-addext latinos/LatinoAnalysis.git LatinoAnalysis
    for i in LatinoAnalysis/NanoGardener/python/data/DYSFmva/201*_alt/TMVAClassification_PyKeras_201*.weightsORIG.xml; do 
        cp ${i} ${i/ORIG/}
        sed -i "s|RPLME_CMSSW_BASE|${CMSSW_BASE}|" ${i/ORIG/}
    done

    echo " - Nano Tools"

    git clone git@github.com:cms-nanoAOD/nanoAOD-tools.git PhysicsTools/NanoAODTools
    cd  PhysicsTools/NanoAODTools
    git checkout a4b3c03
    cd -;
    cp LatinoAnalysis/Tools/data/JECs/*txt PhysicsTools/NanoAODTools/data/jme/
    cp LatinoAnalysis/Tools/data/JECs/*tgz PhysicsTools/NanoAODTools/data/jme/
    cp LatinoAnalysis/NanoGardener/python/data/Summer16_25nsV1b_MC.tgz PhysicsTools/NanoAODTools/data/jme/ 
    cp LatinoAnalysis/NanoGardener/python/data/Fall17_V3b_MC.tgz PhysicsTools/NanoAODTools/data/jme/
    cp LatinoAnalysis/NanoGardener/python/data/Autumn18_V7b_MC.tgz PhysicsTools/NanoAODTools/data/jme/
    

    echo " - Plotting Tools"

    git clone git@github.com:yiiyama/multidraw.git LatinoAnalysis/MultiDraw
    cd LatinoAnalysis/MultiDraw
    git checkout 2.0.12 2>/dev/null
    ./mkLinkDef.py --cmssw
    cd ../..

    echo " - MELA new version"

    git clone git@github.com:MELALabs/MelaAnalytics.git MelaAnalytics
    cd MelaAnalytics ; git checkout -b from-v22 v2.2 ; cd ..
    git clone https://github.com/JHUGen/JHUGenMela.git JHUGenMELA
    cd JHUGenMELA; git checkout -b from-v235 v2.3.5 ; source setup.sh -j 12 ; cd ..

elif [[ "$CMSSW_VERSION" == CMSSW_11_*_* ]]; then
    echo "======================================="
    echo "running with $CMSSW_VERSION - this is a 13 TeV setup!"
    echo "Current time:" $(date)
    echo "checking out additional repositories; this could take a while ..."
    echo "======================================="

    echo " - Basic Code"

    github-addext latinos/LatinoAnalysis.git LatinoAnalysis

    echo " - Nano Tools"

    git clone git@github.com:cms-nanoAOD/nanoAOD-tools.git PhysicsTools/NanoAODTools
    cd  PhysicsTools/NanoAODTools
    git checkout a4b3c03
    cd -;
    cp LatinoAnalysis/Tools/data/JECs/*txt PhysicsTools/NanoAODTools/data/jme/
    cp LatinoAnalysis/Tools/data/JECs/*tgz PhysicsTools/NanoAODTools/data/jme/
    cp LatinoAnalysis/NanoGardener/python/data/Summer16_25nsV1b_MC.tgz PhysicsTools/NanoAODTools/data/jme/ 
    cp LatinoAnalysis/NanoGardener/python/data/Fall17_V3b_MC.tgz PhysicsTools/NanoAODTools/data/jme/
    cp LatinoAnalysis/NanoGardener/python/data/Autumn18_V7b_MC.tgz PhysicsTools/NanoAODTools/data/jme/
    

    echo " - Plotting Tools"

    git clone git@github.com:yiiyama/multidraw.git LatinoAnalysis/MultiDraw
    cd LatinoAnalysis/MultiDraw
    git checkout 2.0.12 2>/dev/null
    ./mkLinkDef.py --cmssw
    cd ../..

    echo " - MELA"

    git clone git@github.com:MELALabs/MelaAnalytics.git MelaAnalytics
    cd MelaAnalytics ; git checkout -b from-v22 v2.2 ; cd ..
    git clone https://github.com/JHUGen/JHUGenMela.git JHUGenMELA
    cd JHUGenMELA; git checkout -b from-v235 v2.3.5 ; source setup.sh -j 12 ; cd ..


elif [[ "$CMSSW_VERSION" == CMSSW_12_*_* ]]; then
    echo "======================================="
    echo "running with $CMSSW_VERSION - this is a 13 TeV setup!"
    echo "Current time:" $(date)
    echo "checking out additional repositories; this could take a while ..."
    echo "======================================="


    echo "++++++++++++ WARNING: Assuming UL setup: using UL_production branch +++++++++++++"

    echo " - Basic Code"

    github-addext latinos/LatinoAnalysis.git LatinoAnalysis
    cd LatinosAnalysis
    git checkout UL_production 
    cd - 

    echo " - Nano Tools"

    git clone git@github.com:cms-nanoAOD/nanoAOD-tools.git PhysicsTools/NanoAODTools
    #should not be needed anymore for UL
    #cd  PhysicsTools/NanoAODTools
    #git checkout a4b3c03
    #cd -;
    cp LatinoAnalysis/Tools/data/JECs/*txt PhysicsTools/NanoAODTools/data/jme/
    cp LatinoAnalysis/Tools/data/JECs/*tgz PhysicsTools/NanoAODTools/data/jme/
    cp LatinoAnalysis/NanoGardener/python/data/Summer16_25nsV1b_MC.tgz PhysicsTools/NanoAODTools/data/jme/
    cp LatinoAnalysis/NanoGardener/python/data/Fall17_V3b_MC.tgz PhysicsTools/NanoAODTools/data/jme/
    cp LatinoAnalysis/NanoGardener/python/data/Autumn18_V7b_MC.tgz PhysicsTools/NanoAODTools/data/jme/


    echo " - Plotting Tools"

    git clone git@github.com:yiiyama/multidraw.git LatinoAnalysis/MultiDraw
    cd LatinoAnalysis/MultiDraw
    git checkout 2.0.12 2>/dev/null
    ./mkLinkDef.py --cmssw
    cd ../..

    echo " - MELA"

    git clone git@github.com:MELALabs/MelaAnalytics.git MelaAnalytics
    cd MelaAnalytics ; git checkout -b from-v21 v2.1 ; cd ..
    git clone https://github.com/cms-analysis/HiggsAnalysis-ZZMatrixElement.git ZZMatrixElement
    cd ZZMatrixElement ; git checkout -b from-v223 v2.2.3 ; source setup.sh -j 12 ; cd ..

#   git clone git@github.com:MELALabs/MelaAnalytics.git MelaAnalytics
#   cd MelaAnalytics ; git checkout -b from-v22 v2.2 ; cd ..
#   git clone https://github.com/JHUGen/JHUGenMela.git JHUGenMELA
#   cd JHUGenMELA; git checkout -b from-v235 v2.3.5 ; source setup.sh -j 12 ; cd ..


    echo " - Correction Lib" 
    git clone ssh://git@gitlab.cern.ch:7999/cms-nanoAOD/jsonpog-integration.git 

else
    echo "======================================="
    echo "You are using release $CMSSW_VERSION which is not supported by this script."
    echo "A with CMSSW_5_*_* release is suggested for shape"
    echo "======================================="

fi;
