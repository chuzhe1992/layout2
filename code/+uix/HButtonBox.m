classdef HButtonBox < uix.ButtonBox
    
    methods
        
        function obj = HButtonBox( varargin )
            
            % Call superclass constructor
            obj@uix.ButtonBox( varargin{:} );
            
        end % constructor
        
    end % structors
    
    methods( Access = protected )
        
        function redraw( obj )
            
            % Compute positions
            bounds = hgconvertunits( ancestor( obj, 'figure' ), ...
                obj.Position, obj.Units, 'pixels', obj.Parent );
            buttonSize = obj.ButtonSize_;
            padding = obj.Padding_;
            spacing = obj.Spacing_;
            c = numel( obj.Contents_ );
            xSizes = repmat( buttonSize(1), [c 1] );
            switch obj.HorizontalAlignment
                case 'left'
                    xPositions = [cumsum( [0; xSizes(1:c-1,:)] ) + ...
                        padding + spacing * transpose( 0:c-1 ) + 1, xSizes];
                case 'center'
                    xPositions = [cumsum( [0; xSizes(1:c-1,:)] ) + ...
                        spacing * transpose( 0:c-1 ) + bounds(3) / 2 - ...
                        sum( xSizes ) / 2 - spacing * (c-1) / 2 + 1, ...
                        xSizes];
                case 'right'
                    xPositions = [cumsum( [0; xSizes(1:c-1,:)] ) + ...
                        spacing * transpose( 0:c-1 ) + bounds(3) - ...
                        sum( xSizes ) - spacing * (c-1) - padding + 1, ...
                        xSizes];
            end
            ySizes = repmat( buttonSize(2), [c 1] );
            switch obj.VerticalAlignment
                case 'top'
                    yPositions = [bounds(4) - ySizes - padding + 1, ySizes];
                case 'middle'
                    yPositions = [(bounds(4) - ySizes) / 2 + 1, ySizes];
                case 'bottom'
                    yPositions = [repmat( padding, [c 1] ) + 1, ySizes];
            end
            positions = [xPositions(:,1), yPositions(:,1), ...
                xPositions(:,2), yPositions(:,2)];
            
            % Set positions
            children = obj.Contents_;
            for ii = 1:numel( children )
                child = children(ii);
                child.Units = 'pixels';
                if isa( child, 'matlab.graphics.axis.Axes' )
                    child.( child.ActivePositionProperty ) = positions(ii,:);
                else
                    child.Position = positions(ii,:);
                end
            end
            
        end % redraw
        
    end % template methods
    
end % classdef