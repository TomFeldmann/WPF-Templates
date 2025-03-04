Add-Type -AssemblyName PresentationFramework
$theme = @'
<!-- Colors -->
<!-- https://coolors.co/24293e-1e2233-2f3855-2a2d43-ffc857-f4f5fc -->
        <SolidColorBrush x:Key="Background" Color="#24293E"/>
        <SolidColorBrush x:Key="scbSecondary" Color="#2f3855"/>
        <SolidColorBrush x:Key="scbThirdly" Color="#2A2D43"/>
        <SolidColorBrush x:Key="scbAccent" Color="#FFC857"/>
        <SolidColorBrush x:Key="scbText" Color="#F4F5FC"/>
        <SolidColorBrush x:Key="scbQuaternary" Color="#1E2233" />
<!-- Accents: #FFC857 #17d149 #e615a7 #56f5ed #ff0000-->
        <Color x:Key="colBackground">#24293E</Color>
        <Color x:Key="colSecondary">#2f3855</Color>
        <Color x:Key="colThirdly">#2A2D43</Color>
        <Color x:Key="colAccent">#FFC857</Color>
        <Color x:Key="colText">#F4F5FC</Color>
        <Color x:Key="colQuaternary">#1E2233</Color>

<!-- MainView Container -->
<Style x:Key="MainViewContainer" TargetType="ItemsControl" >
    <Setter Property="Background" Value="{StaticResource scbThirdly}"/>
    <Setter Property="Foreground" Value="{StaticResource scbText}"/>
    <Setter Property="Padding" Value="2"/>
    <Setter Property="ItemsPanel">
        <Setter.Value>
            <ItemsPanelTemplate>
                <Grid>
                    
                </Grid>
            </ItemsPanelTemplate>
        </Setter.Value>
    </Setter>
</Style>
'@
$schemas= @"
xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
"@

$xaml = @"
<Window
    $schemas
    FontSize="18"
    FontWeight="DemiBold"
    Title="Tomscher Formated Cooldown">
    <Window.Resources>
        <ResourceDictionary>
    $theme

    <!-- Font -->
    <!-- TabItemHeader -->
            <Style x:Key="tfcdTabItemFocusVisual" TargetType="{x:Type TabItem}">
                <Setter Property="Foreground" Value="{StaticResource scbText}"/>
                <Setter Property="Background" Value="{StaticResource scbThirdly}"/>
                <Setter Property="FontWeight" Value="Bold"/>
                <Setter Property="Control.Template">
                    <Setter.Value>
                        <ControlTemplate TargetType="{x:Type TabItem}">
                            <Grid Margin="-2,5,0,0">
                                <Border
                                    x:Name="Border"
                                    Background="{TemplateBinding Background}"
                                    BorderThickness="0,0,0,1"
                                    CornerRadius="1"
                                    Padding="22,5,22,5">
                                    <ContentPresenter ContentSource="Header"/>
                                </Border>
                            </Grid>
                            <ControlTemplate.Triggers>
                                <Trigger Property="TabItem.IsSelected" Value="true">
                                    <Setter TargetName="Border" Property="TextElement.Foreground" Value="{StaticResource scbAccent}"/>
                                    <Setter TargetName="Border" Property="BorderBrush" Value="{StaticResource scbAccent}"/>
                                </Trigger>
                                <MultiTrigger>
                                    <MultiTrigger.Conditions>
                                        <Condition Property="TabItem.IsSelected" Value="true"/>
                                        <Condition Property="TabItem.IsMouseOver" Value="true"/>
                                    </MultiTrigger.Conditions>
                                    <Setter TargetName="Border" Property="Background" Value="{StaticResource scbAccent}"/>
                                </MultiTrigger>
                                <Trigger Property="TabItem.IsMouseOver" Value="true">
                                    <Setter TargetName="Border" Property="TextElement.Foreground" Value="{StaticResource Background}"/>
                                    <Trigger.EnterActions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <ColorAnimation Duration="0:0:0.3" Storyboard.TargetProperty="(Border.Background).(SolidColorBrush.Color)" To="{StaticResource colAccent}"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </Trigger.EnterActions>
                                    <Trigger.ExitActions>
                                        <BeginStoryboard>
                                            <Storyboard>
                                                <ColorAnimation Duration="0:0:0.3" Storyboard.TargetProperty="(Border.Background).(SolidColorBrush.Color)" To="{StaticResource colThirdly}"/>
                                            </Storyboard>
                                        </BeginStoryboard>
                                    </Trigger.ExitActions>
                                </Trigger>
                            </ControlTemplate.Triggers>
                        </ControlTemplate>
                    </Setter.Value>
                </Setter>
            </Style>
    <!-- END:TabItemHeader -->
        </ResourceDictionary>
    </Window.Resources>
    <Grid Margin="0" Background="{StaticResource scbThirdly}">
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="Auto"/>
            <ColumnDefinition Width="3"/>
            <ColumnDefinition Width="*"/>
        </Grid.ColumnDefinitions>
        <Grid.RowDefinitions>
            <RowDefinition Height="*"/>
        </Grid.RowDefinitions>
        <Grid Margin="0" Background="{StaticResource scbSecondary}">
            <TabControl
                Name="tclSidebar"
                Grid.Column="0"
                HorizontalAlignment="Left"
                Margin="0,0,0,0"
                VerticalAlignment="Top"
                Background="Transparent"
                BorderThickness="0"
                Foreground="{StaticResource scbText}"
                Padding="0"
                TabStripPlacement="Left">
                <TabItem Name="test" Header="Format Einstellungen" Style="{StaticResource tfcdTabItemFocusVisual}"/>
                <TabItem Header="Zeit Einstellungen" Style="{StaticResource tfcdTabItemFocusVisual}"/>
                <TabItem Header="Erweiterte Einstellungen" Style="{StaticResource tfcdTabItemFocusVisual}"/>
            </TabControl>
        </Grid>
    <!-- Separator Line -->
        <Border Width="auto" Grid.Column="1" Background="{StaticResource scbQuaternary}">
            <Border.Effect>
                <DropShadowEffect ShadowDepth="3" Opacity="0.2" Color="{StaticResource colThirdly}"/>
            </Border.Effect>
        </Border>
        <Grid Grid.Column="2">
            <ContentControl Name="cclMainView" Margin="8">
                <TextBlock Name="tbkTest" FontSize="14" Foreground="Gray" Text="Select a Tab"/>
            </ContentControl>
        </Grid>
    </Grid>
</Window>
"@
$reader = [System.Xml.XmlReader]::Create([System.IO.StringReader]$xaml)
$window = [System.Windows.Markup.XamlReader]::Load($reader)

$tclSidebar = $window.findname("tclSidebar")
$cclMainView = $window.findname("cclMainView")

# Event Handler for TabControl SelectionChanged
         
$TabControl_SelectionChanged = [System.Windows.Controls.SelectionChangedEventHandler]{
    param ($sender, $e)
    switch ($sender.SelectedIndex) {
        0 { $cclMainView.Content = [System.Windows.Markup.XamlReader]::Parse(@"
<Grid $schemas>
    <Grid.Resources>
        <ResourceDictionary>
            $theme
        </ResourceDictionary>
    </Grid.Resources>
    <ItemsControl Style="{StaticResource MainViewContainer}">
        <TextBlock Text="Inhalt für Format Einstellungen"/>
    </ItemsControl>
</Grid>
"@
) }

                    1 { $cclMainView.Content = [System.Windows.Markup.XamlReader]::Parse(@"
<Grid $schemas>
    <Grid.Resources>
        <ResourceDictionary>
            $theme
        </ResourceDictionary>
    </Grid.Resources>
    <ItemsControl Style="{StaticResource MainViewContainer}">
        <TextBlock Text="Inhalt für Basis Einstellungen"/>
    </ItemsControl>
</Grid>
"@
) }

                    2 { $cclMainView.Content = [System.Windows.Markup.XamlReader]::Parse(@"
<Grid $schemas>
    <Grid.Resources>
        <ResourceDictionary>
            $theme
        </ResourceDictionary>
    </Grid.Resources>
    <ItemsControl Style="{StaticResource MainViewContainer}">
        <TextBlock Text="Inhalt für Erweiterte Einstellungen"/>
    </ItemsControl>
</Grid>
"@
) }


    }
}
            

$tclSidebar.Add_SelectionChanged($TabControl_SelectionChanged)
$window.ShowDialog() | Out-Null