//Maya ASCII 8.5 scene

// Wraith - Game extraction tools
// Please credit DTZxPorter for using it!

requires maya "8.5";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya Unlimited 8.5";
fileInfo "version" "8.5";
fileInfo "cutIdentifier" "200612162224-692032";
createNode transform -s -n "persp";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 48.186233840145825 37.816674066853686 41.0540421364379 ;
	setAttr ".r" -type "double3" -29.738352729603015 49.400000000000432 0 ;
createNode camera -s -n "perspShape" -p "persp";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".fcp" 10000;
	setAttr ".coi" 73.724849603665149;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 100.1 0 ;
	setAttr ".r" -type "double3" -89.999999999999986 0 0 ;
createNode camera -s -n "topShape" -p "top";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".hc" -type "string" "viewSet -t %camera";
	setAttr ".o" yes;
createNode transform -s -n "front";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 100.1 ;
createNode camera -s -n "frontShape" -p "front";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "front";
	setAttr ".den" -type "string" "front_depth";
	setAttr ".man" -type "string" "front_mask";
	setAttr ".hc" -type "string" "viewSet -f %camera";
	setAttr ".o" yes;
createNode transform -s -n "side";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 100.1 0 0 ;
	setAttr ".r" -type "double3" 0 89.999999999999986 0 ;
createNode camera -s -n "sideShape" -p "side";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 100.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode lightLinker -n "lightLinker1";
	setAttr -s 9 ".lnk";
	setAttr -s 9 ".slnk";
createNode displayLayerManager -n "layerManager";
createNode displayLayer -n "defaultLayer";
createNode renderLayerManager -n "renderLayerManager";
createNode renderLayer -n "defaultRenderLayer";
	setAttr ".g" yes;
createNode script -n "sceneConfigurationScriptNode";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 24 -ast 1 -aet 48 ";
	setAttr ".st" 6;
select -ne :time1;
	setAttr ".o" 1;
select -ne :renderPartition;
	setAttr -s 2 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 2 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :lightList1;
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
select -ne :ikSystem;
	setAttr -s 4 ".sol";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[0].llnk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.lnk[0].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[1].llnk";
connectAttr ":initialParticleSE.msg" "lightLinker1.lnk[1].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[0].sllk";
connectAttr ":initialShadingGroup.msg" "lightLinker1.slnk[0].solk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[1].sllk";
connectAttr ":initialParticleSE.msg" "lightLinker1.slnk[1].solk";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "lightLinker1.msg" ":lightList1.ln" -na;
createNode transform -n "projectile_us_smoke_grenade_LOD2";
setAttr ".ove" yes;
createNode transform -n "WraithMesh_4d952f7d_00" -p "projectile_us_smoke_grenade_LOD2";
setAttr ".rp" -type "double3" 0.000000 0.000000 0.000000 ;
setAttr ".sp" -type "double3" 0.000000 0.000000 0.000000 ;
createNode mesh -n "MeshShape_0" -p "WraithMesh_4d952f7d_00";
setAttr -k off ".v";
setAttr ".vir" yes;
setAttr ".vif" yes;
setAttr ".iog[0].og[0].gcl" -type "componentList" 1 "f[0:75]";
setAttr ".uvst[0].uvsn" -type "string" "map1";
setAttr -s 75 ".uvst[0].uvsp";
setAttr ".uvst[0].uvsp[0:74]" -type "float2" 0.061554 0.774658 0.231445 0.774658 0.102600 0.839966 0.231445 0.839966 0.061096 0.774658 0.102112 0.839966 0.230957 0.774658 0.230957 0.839966 0.102112 0.931335 0.230957 0.931335 0.102112 0.839966 0.230957 0.931335 0.256104 0.826904 0.329834 0.944336 0.329834 0.826660 0.018982 0.839966 0.018982 0.931335 0.102112 0.839966 0.102112 0.931335 0.465088 0.787720 0.619629 0.787720 0.497070 0.846069 0.619629 0.846069 0.465088 0.787598 0.497070 0.846069 0.619629 0.787598 0.623047 0.847168 0.623047 0.847168 0.623047 0.932007 0.683105 0.847778 0.683105 0.931458 0.430420 0.846069 0.430420 0.933167 0.497070 0.846069 0.497070 0.933167 0.858398 0.605957 0.761230 0.508789 0.761230 0.703369 0.664063 0.605957 0.858398 0.605957 0.761230 0.703369 0.761230 0.508545 0.663574 0.605957 0.762695 0.474609 0.762695 0.463379 0.666016 0.377930 0.677246 0.377930 0.666016 0.377930 0.677246 0.377930 0.762695 0.281250 0.762695 0.291992 0.762695 0.281250 0.762695 0.291992 0.859863 0.377930 0.848633 0.377930 0.859863 0.377930 0.848633 0.377930 0.762695 0.474609 0.762695 0.463379 0.762695 0.463379 0.848633 0.377930 0.677246 0.377930 0.762695 0.291992 0.332275 0.018066 0.332275 0.749756 0.492188 0.019531 0.486816 0.751465 0.646484 0.021484 0.646484 0.753174 0.332275 0.749756 0.332275 0.018066 0.177612 0.751343 0.172363 0.019531 0.017883 0.753174 0.017838 0.021484;
setAttr ".cuvs" -type "string" "map1";
setAttr ".dcol" yes;
setAttr ".dcc" -type "string" "Ambient+Diffuse";
setAttr ".ccls" -type "string" "colorSet1";
setAttr ".clst[0].clsn" -type "string" "colorSet1";
setAttr -s 120 ".clst[0].clsp";
setAttr ".clst[0].clsp[0:119]" 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000;
setAttr ".covm[0]"  0 1 1;
setAttr ".cdvm[0]"  0 1 1;
setAttr -s 75 ".vt";
setAttr ".vt[0:74]" -1.830954 0.717210 5.426423 0.527215 0.717210 5.426423 -1.261323 0.717210 6.450825 0.527215 0.717210 6.450825 -1.830954 -0.717207 5.426423 -1.261323 -0.717207 6.450825 0.527215 -0.717207 5.426423 0.527215 -0.717207 6.450825 -1.261323 0.717210 6.450825 0.527215 0.717210 6.450825 -1.261323 -0.717207 6.450825 0.527215 0.717210 6.450825 0.527215 -0.717207 6.450825 0.527215 0.717210 5.426423 0.527215 -0.717207 5.426423 -1.830954 -0.717207 5.426423 -1.830954 0.717210 5.426423 -1.261323 -0.717207 6.450825 -1.261323 0.717210 6.450825 -1.391272 0.543911 6.372370 0.560354 0.521274 6.372372 -0.990981 0.543911 7.101726 0.560354 0.521274 7.101726 -1.391272 -0.543911 6.372370 -0.990981 -0.543911 7.101726 0.560354 -0.521274 6.372372 0.560354 -0.521274 7.101726 0.560354 -0.521274 7.101726 0.560354 0.521274 7.101726 0.560354 -0.521274 6.372372 0.560354 0.521274 6.372372 -1.391272 -0.543911 6.372370 -1.391272 0.543911 6.372370 -0.990981 -0.543911 7.101726 -0.990981 0.543911 7.101726 2.727505 0.000000 5.163891 0.000000 -2.727505 5.163891 0.000000 2.727508 5.163891 -2.727505 0.000000 5.163891 2.731201 0.000000 -7.245649 0.000000 2.731201 -7.245649 0.000000 -2.731201 -7.245649 -2.731201 0.000000 -7.245649 0.000000 1.883964 5.124272 0.000000 1.858747 5.497816 -1.883964 0.000000 5.124272 -1.858746 0.000000 5.497816 -1.883964 0.000000 5.124272 -1.858746 0.000000 5.497816 0.000000 -1.883964 5.124272 0.000000 -1.858746 5.497816 0.000000 -1.883964 5.124272 0.000000 -1.858746 5.497816 1.883961 0.000000 5.124272 1.858747 0.000000 5.497816 1.883961 0.000000 5.124272 1.858747 0.000000 5.497816 0.000000 1.883964 5.124272 0.000000 1.858747 5.497816 0.000000 1.858747 5.497816 1.858747 0.000000 5.497816 -1.858746 0.000000 5.497816 0.000000 -1.858746 5.497816 0.000000 2.731201 -7.245649 0.000000 2.727508 5.163891 -2.731201 0.000000 -7.245649 -2.727505 0.000000 5.163891 0.000000 -2.731201 -7.245649 0.000000 -2.727505 5.163891 0.000000 2.727508 5.163891 0.000000 2.731201 -7.245649 2.727505 0.000000 5.163891 2.731201 0.000000 -7.245649 0.000000 -2.727505 5.163891 0.000000 -2.731201 -7.245649;
setAttr -s 120 ".ed";
setAttr ".ed[0:119]" 2 1 0 1 0 0 0 2 0 3 1 0 1 2 0 2 3 0 6 5 0 5 4 0 4 6 0 7 5 0 5 6 0 6 7 0 10 9 0 9 8 0 8 10 0 12 11 0 11 10 0 10 12 0 12 13 0 13 9 0 9 12 0 13 12 0 12 14 0 14 13 0 17 16 0 16 15 0 15 17 0 18 16 0 16 17 0 17 18 0 21 20 0 20 19 0 19 21 0 22 20 0 20 21 0 21 22 0 25 24 0 24 23 0 23 25 0 26 24 0 24 25 0 25 26 0 29 28 0 28 27 0 27 29 0 30 28 0 28 29 0 29 30 0 33 32 0 32 31 0 31 33 0 34 32 0 32 33 0 33 34 0 37 36 0 36 35 0 35 37 0 38 36 0 36 37 0 37 38 0 41 40 0 40 39 0 39 41 0 42 40 0 40 41 0 41 42 0 45 44 0 44 43 0 43 45 0 44 45 0 45 46 0 46 44 0 49 48 0 48 47 0 47 49 0 48 49 0 49 50 0 50 48 0 53 52 0 52 51 0 51 53 0 52 53 0 53 54 0 54 52 0 57 56 0 56 55 0 55 57 0 56 57 0 57 58 0 58 56 0 61 60 0 60 59 0 59 61 0 62 60 0 60 61 0 61 62 0 65 64 0 64 63 0 63 65 0 65 66 0 66 64 0 64 65 0 67 66 0 66 65 0 65 67 0 68 66 0 66 67 0 67 68 0 71 70 0 70 69 0 69 71 0 71 72 0 72 70 0 70 71 0 73 72 0 72 71 0 71 73 0 72 73 0 73 74 0 74 72 0;
setAttr -s 120 ".n";
setAttr ".n[0:119]" -type "float3" 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 -1.000000 0.000000 0.000000 -1.000000 0.000000 0.000000 -1.000000 0.000000 0.000000 -1.000000 0.000000 0.000000 -1.000000 0.000000 0.000000 -1.000000 0.000000 0.496063 0.000000 0.866142 0.496063 0.000000 0.866142 0.496063 0.000000 0.866142 0.496063 0.000000 0.866142 0.496063 0.000000 0.866142 0.496063 0.000000 0.866142 0.496063 0.000000 0.866142 0.496063 0.000000 0.866142 0.496063 0.000000 0.866142 0.496063 0.000000 0.866142 0.496063 0.000000 0.866142 0.496063 0.000000 0.866142 -0.874016 0.000000 0.488189 -0.874016 0.000000 0.488189 -0.874016 0.000000 0.488189 -0.874016 0.000000 0.488189 -0.874016 0.000000 0.488189 -0.874016 0.000000 0.488189 0.015748 1.000000 0.000000 0.015748 1.000000 0.000000 0.015748 1.000000 0.000000 0.015748 1.000000 0.000000 0.015748 1.000000 0.000000 0.015748 1.000000 0.000000 0.015748 -1.000000 0.000000 0.015748 -1.000000 0.000000 0.015748 -1.000000 0.000000 0.015748 -1.000000 0.000000 0.015748 -1.000000 0.000000 0.015748 -1.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 -0.874016 0.000000 0.480315 -0.874016 0.000000 0.480315 -0.874016 0.000000 0.480315 -0.874016 0.000000 0.480315 -0.874016 0.000000 0.480315 -0.874016 0.000000 0.480315 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 -1.000000 0.000000 0.000000 -1.000000 0.000000 0.000000 -1.000000 0.000000 0.000000 -1.000000 0.000000 0.000000 -1.000000 0.000000 0.000000 -1.000000 -1.000000 0.000000 0.070866 0.000000 1.000000 0.070866 0.000000 1.000000 0.070866 0.000000 1.000000 0.070866 -1.000000 0.000000 0.070866 -1.000000 0.000000 0.070866 0.000000 -1.000000 0.070866 -1.000000 0.000000 0.070866 -1.000000 0.000000 0.070866 -1.000000 0.000000 0.070866 0.000000 -1.000000 0.070866 0.000000 -1.000000 0.070866 1.000000 0.000000 0.070866 0.000000 -1.000000 0.070866 0.000000 -1.000000 0.070866 0.000000 -1.000000 0.070866 1.000000 0.000000 0.070866 1.000000 0.000000 0.070866 0.000000 1.000000 0.070866 1.000000 0.000000 0.070866 1.000000 0.000000 0.070866 1.000000 0.000000 0.070866 0.000000 1.000000 0.070866 0.000000 1.000000 0.070866 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 -1.000000 0.000000 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 -1.000000 0.000000 0.000000 -1.000000 0.000000 0.000000 0.000000 1.000000 0.000000 0.000000 -1.000000 0.000000 -1.000000 0.000000 0.000000 -1.000000 0.000000 0.000000 0.000000 -1.000000 0.000000 -1.000000 0.000000 0.000000 0.000000 -1.000000 0.000000 1.000000 0.000000 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 0.000000 1.000000 0.000000 0.000000 -1.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 1.000000 0.000000 0.000000 0.000000 -1.000000 0.000000 0.000000 -1.000000 0.000000;
setAttr -s 40 ".fc[0:39]" -type "polyFaces" f 3 0 1 2 mu 0 3 2 1 0 mc 0 3 0 1 2 f 3 3 4 5 mu 0 3 3 1 2 mc 0 3 3 4 5 f 3 6 7 8 mu 0 3 6 5 4 mc 0 3 6 7 8 f 3 9 10 11 mu 0 3 7 5 6 mc 0 3 9 10 11 f 3 12 13 14 mu 0 3 10 9 8 mc 0 3 12 13 14 f 3 15 16 17 mu 0 3 12 11 10 mc 0 3 15 16 17 f 3 18 19 20 mu 0 3 12 13 9 mc 0 3 18 19 20 f 3 21 22 23 mu 0 3 13 12 14 mc 0 3 21 22 23 f 3 24 25 26 mu 0 3 17 16 15 mc 0 3 24 25 26 f 3 27 28 29 mu 0 3 18 16 17 mc 0 3 27 28 29 f 3 30 31 32 mu 0 3 21 20 19 mc 0 3 30 31 32 f 3 33 34 35 mu 0 3 22 20 21 mc 0 3 33 34 35 f 3 36 37 38 mu 0 3 25 24 23 mc 0 3 36 37 38 f 3 39 40 41 mu 0 3 26 24 25 mc 0 3 39 40 41 f 3 42 43 44 mu 0 3 29 28 27 mc 0 3 42 43 44 f 3 45 46 47 mu 0 3 30 28 29 mc 0 3 45 46 47 f 3 48 49 50 mu 0 3 33 32 31 mc 0 3 48 49 50 f 3 51 52 53 mu 0 3 34 32 33 mc 0 3 51 52 53 f 3 54 55 56 mu 0 3 37 36 35 mc 0 3 54 55 56 f 3 57 58 59 mu 0 3 38 36 37 mc 0 3 57 58 59 f 3 60 61 62 mu 0 3 41 40 39 mc 0 3 60 61 62 f 3 63 64 65 mu 0 3 42 40 41 mc 0 3 63 64 65 f 3 66 67 68 mu 0 3 45 44 43 mc 0 3 66 67 68 f 3 69 70 71 mu 0 3 44 45 46 mc 0 3 69 70 71 f 3 72 73 74 mu 0 3 49 48 47 mc 0 3 72 73 74 f 3 75 76 77 mu 0 3 48 49 50 mc 0 3 75 76 77 f 3 78 79 80 mu 0 3 53 52 51 mc 0 3 78 79 80 f 3 81 82 83 mu 0 3 52 53 54 mc 0 3 81 82 83 f 3 84 85 86 mu 0 3 57 56 55 mc 0 3 84 85 86 f 3 87 88 89 mu 0 3 56 57 58 mc 0 3 87 88 89 f 3 90 91 92 mu 0 3 61 60 59 mc 0 3 90 91 92 f 3 93 94 95 mu 0 3 62 60 61 mc 0 3 93 94 95 f 3 96 97 98 mu 0 3 65 64 63 mc 0 3 96 97 98 f 3 99 100 101 mu 0 3 65 66 64 mc 0 3 99 100 101 f 3 102 103 104 mu 0 3 67 66 65 mc 0 3 102 103 104 f 3 105 106 107 mu 0 3 68 66 67 mc 0 3 105 106 107 f 3 108 109 110 mu 0 3 71 70 69 mc 0 3 108 109 110 f 3 111 112 113 mu 0 3 71 72 70 mc 0 3 111 112 113 f 3 114 115 116 mu 0 3 73 72 71 mc 0 3 114 115 116 f 3 117 118 119 mu 0 3 72 73 74 mc 0 3 117 118 119;
setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;

createNode shadingEngine -n "mtl_us_smoke_grenadeSG";
    setAttr ".ihi" 0;
    setAttr ".ro" yes;
createNode materialInfo -n "mtl_us_smoke_grenadeMI";
createNode phong -n "mtl_us_smoke_grenade";
    setAttr ".ambc" -type "float3" 1 1 1 ;
createNode file -n "mtl_us_smoke_grenadeFILE";
    setAttr ".ftn" -type "string" "..\\_images\\us_smoke_grenade_c.tga";
createNode place2dTexture -n "mtl_us_smoke_grenadeP2DT";

connectAttr ":defaultLightSet.msg" "lightLinker1.lnk[2].llnk";
connectAttr "mtl_us_smoke_grenadeSG.msg" "lightLinker1.lnk[2].olnk";
connectAttr ":defaultLightSet.msg" "lightLinker1.slnk[2].sllk";
connectAttr "mtl_us_smoke_grenadeSG.msg" "lightLinker1.slnk[2].solk";
connectAttr "mtl_us_smoke_grenade.oc" "mtl_us_smoke_grenadeSG.ss";
connectAttr "mtl_us_smoke_grenadeSG.msg" "mtl_us_smoke_grenadeMI.sg";
connectAttr "mtl_us_smoke_grenade.msg" "mtl_us_smoke_grenadeMI.m";
connectAttr "mtl_us_smoke_grenadeFILE.msg" "mtl_us_smoke_grenadeMI.t" -na;
connectAttr "mtl_us_smoke_grenadeFILE.oc" "mtl_us_smoke_grenade.c";
connectAttr "mtl_us_smoke_grenadeP2DT.c" "mtl_us_smoke_grenadeFILE.c";
connectAttr "mtl_us_smoke_grenadeP2DT.tf" "mtl_us_smoke_grenadeFILE.tf";
connectAttr "mtl_us_smoke_grenadeP2DT.rf" "mtl_us_smoke_grenadeFILE.rf";
connectAttr "mtl_us_smoke_grenadeP2DT.mu" "mtl_us_smoke_grenadeFILE.mu";
connectAttr "mtl_us_smoke_grenadeP2DT.mv" "mtl_us_smoke_grenadeFILE.mv";
connectAttr "mtl_us_smoke_grenadeP2DT.s" "mtl_us_smoke_grenadeFILE.s";
connectAttr "mtl_us_smoke_grenadeP2DT.wu" "mtl_us_smoke_grenadeFILE.wu";
connectAttr "mtl_us_smoke_grenadeP2DT.wv" "mtl_us_smoke_grenadeFILE.wv";
connectAttr "mtl_us_smoke_grenadeP2DT.re" "mtl_us_smoke_grenadeFILE.re";
connectAttr "mtl_us_smoke_grenadeP2DT.of" "mtl_us_smoke_grenadeFILE.of";
connectAttr "mtl_us_smoke_grenadeP2DT.r" "mtl_us_smoke_grenadeFILE.ro";
connectAttr "mtl_us_smoke_grenadeP2DT.n" "mtl_us_smoke_grenadeFILE.n";
connectAttr "mtl_us_smoke_grenadeP2DT.vt1" "mtl_us_smoke_grenadeFILE.vt1";
connectAttr "mtl_us_smoke_grenadeP2DT.vt2" "mtl_us_smoke_grenadeFILE.vt2";
connectAttr "mtl_us_smoke_grenadeP2DT.vt3" "mtl_us_smoke_grenadeFILE.vt3";
connectAttr "mtl_us_smoke_grenadeP2DT.vc1" "mtl_us_smoke_grenadeFILE.vc1";
connectAttr "mtl_us_smoke_grenadeP2DT.o" "mtl_us_smoke_grenadeFILE.uv";
connectAttr "mtl_us_smoke_grenadeP2DT.ofs" "mtl_us_smoke_grenadeFILE.fs";

connectAttr "mtl_us_smoke_grenadeSG.pa" ":renderPartition.st" -na;
connectAttr "mtl_us_smoke_grenade.msg" ":defaultShaderList1.s" -na;
connectAttr "mtl_us_smoke_grenadeP2DT.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "mtl_us_smoke_grenadeFILE.msg" ":defaultTextureList1.tx" -na;

connectAttr "mtl_us_smoke_grenadeSG.mwc" "MeshShape_0.iog.og[0].gco";
connectAttr "MeshShape_0.iog" "mtl_us_smoke_grenadeSG.dsm" -na;
createNode transform -n "Joints";
setAttr ".ove" yes;

createNode joint -n "polysurface22" -p "Joints";
addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -bt "lock" -min 0 -max 1 -at "bool";
setAttr ".uoc" yes;
setAttr ".ove" yes;
setAttr ".t" -type "double3"  0.000000 0.000000 0.000000 ;
setAttr ".mnrl" -type "double3" -360 -360 -360 ;
setAttr ".mxrl" -type "double3" 360 360 360 ;
setAttr ".radi"   0.50;
setAttr ".jo" -type "double3" 0.000000 -0.000000 0.000000;
setAttr ".scale" -type "double3" 1.000000 1.000000 1.000000;

