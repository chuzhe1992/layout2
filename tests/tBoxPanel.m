classdef tBoxPanel  < ContainerSharedTests ...
        & PanelTests
%TBOXPANEL unit tests for uiextras.BoxPanel
    
    properties (TestParameter)
        ContainerType   = {'uiextras.BoxPanel'};
        GetSetArgs = {
            {'BackgroundColor',  [1 1 0], ...
            'IsMinimized',     false, ...
            'IsDocked',        true, ...
            'BorderType',      'etchedout', ...
            'BorderWidth',     10, ...
            'Title',           'box panel test', ...
            'TitleColor',      [1 0 0], ...
            'ForegroundColor', [1 1 1], ...
            'HighlightColor',  [1 0 1], ...
            'ShadowColor',     [0 0 0]
            }};
        ConstructorArgs = {
            {'Units',      'pixels', ...
            'Position',    [10 10 400 400], ...
            'Padding',     5, ...
            'Tag',         'Test', ...
            'Visible',     'on', ...
            'BorderType',  'etchedout', ...
            'FontAngle',   'normal', ...
            'FontName',    'Arial', ...
            'FontSize',    20, ...
            'FontUnits',   'points', ...
            'FontWeight',  'bold'
            }};
    end
    
end
