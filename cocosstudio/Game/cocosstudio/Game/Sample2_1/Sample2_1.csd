<GameFile>
  <PropertyGroup Name="Sample2_1" Type="Scene3D" ID="1f7962eb-0776-41a1-a09a-7150722432fc" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="0" Speed="1.0000" />
      <ObjectData Name="Scene3D" Tag="45" UseDefaultLight="True" SkyBoxEnabled="False" SkyBoxValid="True" SkyBoxMask="1024" ctype="GameNode3DObjectData">
        <Size X="0.0000" Y="0.0000" />
        <Children>
          <AbstractNodeData Name="KK_CAMERA" CameraFlagMode="31" Fov="60.0000" UserCameraFlagMode="USER1" CameraFlagData="1026" SkyBoxEnabled="False" SkyBoxValid="True" ctype="UserCameraObjectData">
            <Size X="0.0000" Y="0.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <Position3D Y="150.0000" Z="600.0000" />
            <Rotation3D />
            <Scale3D X="1.0000" Y="1.0000" Z="1.0000" />
            <ClipPlane X="1.0000" Y="1000.0000" />
            <LeftImage Type="Default" Path="Default/skybox.png" Plist="" />
            <RightImage Type="Default" Path="Default/skybox.png" Plist="" />
            <UpImage Type="Default" Path="Default/skybox.png" Plist="" />
            <DownImage Type="Default" Path="Default/skybox.png" Plist="" />
            <ForwardImage Type="Default" Path="Default/skybox.png" Plist="" />
            <BackImage Type="Default" Path="Default/skybox.png" Plist="" />
          </AbstractNodeData>
          <AbstractNodeData Name="DirectionLight" CameraFlagMode="31" Type="POINT" Flag="LIGHT1" ctype="Light3DObjectData">
            <Size X="0.0000" Y="0.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <Position3D Y="200.0000" />
            <Rotation3D />
            <Scale3D X="1.0000" Y="1.0000" Z="1.0000" />
          </AbstractNodeData>
          <AbstractNodeData Name="KK_NODE_ALL" ActionTag="27444733" Tag="9" CameraFlagMode="2" ctype="Node3DObjectData">
            <Size X="1.0000" Y="1.0000" />
            <Children>
              <AbstractNodeData Name="KK_MODEL_FLOOR" ActionTag="2086403413" Tag="10" CameraFlagMode="30" LightFlag="LIGHT0" ctype="Sprite3DObjectData">
                <Size X="500.0000" Y="0.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <Position3D />
                <Rotation3D X="-90.0000" />
                <Scale3D X="3.0000" Y="3.0000" Z="3.0000" />
                <FileData Type="Normal" Path="Game/Sample2_1/model/floor.c3t" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="KK_MODEL_CAR" ActionTag="-921221986" Tag="48" CameraFlagMode="2" LightFlag="LIGHT0" ctype="Sprite3DObjectData">
                <Size X="73.5270" Y="46.0504" />
                <CColor A="255" R="255" G="255" B="255" />
                <Position3D Z="100.0000" />
                <Rotation3D X="-90.0000" />
                <Scale3D X="2.2000" Y="2.2000" Z="2.2000" />
                <FileData Type="Normal" Path="Game/Sample2_1/model/car.c3t" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="KK_GUANMU_1" ActionTag="-672828581" Tag="11" CameraFlagMode="30" LightFlag="LIGHT0" ctype="Sprite3DObjectData">
                <Size X="207.7946" Y="235.9002" />
                <CColor A="255" R="255" G="255" B="255" />
                <Position3D X="-200.0000" Y="40.0000" Z="-150.0000" />
                <Rotation3D />
                <Scale3D X="0.3000" Y="0.3000" Z="0.3000" />
                <FileData Type="Normal" Path="Game/Sample2_1/model/guanMu.c3t" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="KK_GUANMU_2" ActionTag="-557360217" Tag="12" CameraFlagMode="30" LightFlag="LIGHT0" ctype="Sprite3DObjectData">
                <Size X="0.0000" Y="0.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <Position3D Y="40.0000" Z="-150.0000" />
                <Rotation3D />
                <Scale3D X="0.3000" Y="0.3000" Z="0.3000" />
                <FileData Type="Normal" Path="Game/Sample2_1/model/guanMu.c3t" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="KK_GUANMU_3" ActionTag="1632702301" Tag="13" CameraFlagMode="30" LightFlag="LIGHT0" ctype="Sprite3DObjectData">
                <Size X="0.0000" Y="0.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <Position3D X="200.0000" Y="40.0000" Z="-150.0000" />
                <Rotation3D />
                <Scale3D X="0.3000" Y="0.3000" Z="0.3000" />
                <FileData Type="Normal" Path="Game/Sample2_1/model/guanMu.c3t" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="KK_CH_1" ActionTag="1892808437" Tag="14" CameraFlagMode="30" LightFlag="LIGHT0" ctype="Sprite3DObjectData">
                <Size X="72.8610" Y="35.7044" />
                <CColor A="255" R="255" G="255" B="255" />
                <Position3D X="200.0000" Z="100.0000" />
                <Rotation3D X="-90.0000" Y="-45.0000" />
                <Scale3D X="3.1500" Y="3.1500" Z="3.1500" />
                <FileData Type="Normal" Path="Game/Sample2_1/model/chahu.c3t" Plist="" />
              </AbstractNodeData>
              <AbstractNodeData Name="KK_CH_2" ActionTag="411601732" Tag="15" CameraFlagMode="30" LightFlag="LIGHT0" ctype="Sprite3DObjectData">
                <Size X="0.0000" Y="0.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <Position3D X="-200.0000" Z="100.0000" />
                <Rotation3D X="-90.0000" Y="200.0000" />
                <Scale3D X="3.1500" Y="3.1500" Z="3.1500" />
                <FileData Type="Normal" Path="Game/Sample2_1/model/chahu.c3t" Plist="" />
              </AbstractNodeData>
            </Children>
            <CColor A="255" R="255" G="255" B="255" />
            <Position3D />
            <Rotation3D />
            <Scale3D X="1.0000" Y="1.0000" Z="1.0000" />
          </AbstractNodeData>
        </Children>
        <LeftImage Type="Default" Path="Default/skybox.png" Plist="" />
        <RightImage Type="Default" Path="Default/skybox.png" Plist="" />
        <UpImage Type="Default" Path="Default/skybox.png" Plist="" />
        <DownImage Type="Default" Path="Default/skybox.png" Plist="" />
        <ForwardImage Type="Default" Path="Default/skybox.png" Plist="" />
        <BackImage Type="Default" Path="Default/skybox.png" Plist="" />
      </ObjectData>
    </Content>
  </Content>
</GameFile>