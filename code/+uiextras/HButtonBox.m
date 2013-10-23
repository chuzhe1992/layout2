classdef HButtonBox < uix.HButtonBox
    %uiextras.HButtonBox  Arrange buttons horizontally in a single row
    %
    %   obj = uiextras.HButtonBox() is a type of HBox specialised for
    %   arranging a row of buttons, check-boxes or similar graphical
    %   elements. All buttons are given equal size and by default are
    %   centered in the drawing area. The justification can be changed as
    %   required.
    %
    %   obj = uiextras.HButtonBox(param,value,...) also sets one or more
    %   parameter values.
    %
    %   See the <a href="matlab:doc uiextras.HButtonBox">documentation</a> for more detail and the list of properties.
    %
    %   Examples:
    %   >> f = figure();
    %   >> b = uiextras.HButtonBox( 'Parent', f );
    %   >> uicontrol( 'Parent', b, 'String', 'One' );
    %   >> uicontrol( 'Parent', b, 'String', 'Two' );
    %   >> uicontrol( 'Parent', b, 'String', 'Three' );
    %   >> set( b, 'ButtonSize', [130 35], 'Spacing', 5 );
    %
    %   See also: uiextras.VButtonBox
    %             uiextras.HBox
    
    %   Copyright 2009-2010 The MathWorks, Inc.
    %   $Revision: 300 $ $Date: 2010-07-22 16:33:47 +0100 (Thu, 22 Jul 2010) $
    
    methods
        
        function obj = HButtonBox( varargin )
            %uiextras.HButtonBox  Create a new horizontal button box
            
            % Warn
            warning( 'uiextras:Deprecated', ...
                'uiextras.HButtonBox is deprecated.  Please use uix.HButtonBox instead.' )
            
            % Do
            obj@uix.HButtonBox( varargin{:} )
            
        end % constructor
        
    end % structors
    
end % classdef