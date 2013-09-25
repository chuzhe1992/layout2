classdef MouseObserver < handle
    
    properties
        Subject
        FigureObserver
        FigureListener
        VisibilityObserver
        VisibilityListener
        WindowStyleListeners
        WindowStyle
        MouseMotionListener
        MouseOver
    end
    
    events
        MouseMotion
        MouseEnter
        MouseLeave
    end
    
    methods
        
        function obj = MouseObserver( subject )
            
            % Create figure observer and listener
            figureObserver = uix.FigureObserver( subject );
            figureListener = event.listener( figureObserver, ...
                'FigureChanged', @obj.onFigureChanged );
            
            % Create visibility observer and listener
            visibilityObserver = uix.VisibilityObserver( subject );
            visibilityListener = event.listener( visibilityObserver, ...
                'VisibilityChanged', @obj.onVisibilityChanged );
            
            % Store properties
            obj.Subject = subject;
            obj.FigureObserver = figureObserver;
            obj.FigureListener = figureListener;
            obj.VisibilityObserver = visibilityObserver;
            obj.VisibilityListener = visibilityListener;
            
            % Force onFigureChanged
            obj.onFigureChanged()
            
            % Force onVisibilityChanged
            obj.onVisibilityChanged()
            
        end % constructor
        
    end % structors
    
    methods
        
        function onFigureChanged( obj, ~, ~ )
            
            % Create figure listeners
            figure = obj.FigureObserver.Figure;
            mouseMotionListener = event.listener( figure, ...
                'WindowMouseMotion', @obj.onMouseMotion );
            windowStyleListeners(1) = event.proplistener( figure, ...
                findprop( figure, 'WindowStyle' ), 'PreSet', ...
                @obj.onWindowStylePreSet );
            windowStyleListeners(2) = event.proplistener( figure, ...
                findprop( figure, 'WindowStyle' ), 'PostSet', ...
                @obj.onWindowStylePostSet );
            
            % Store properties
            obj.MouseMotionListener = mouseMotionListener;
            obj.WindowStyleListeners = windowStyleListeners;
            
            % Set caches
            obj.WindowStyle = figure.WindowStyle;
            obj.MouseOver = false;
            
            
        end % onFigureChanged
        
        function onVisibilityChanged( obj, ~, ~ )
            
            obj.MouseMotionListener.Enabled = obj.VisibilityObserver.Visible;
            
        end % onVisibilityChanged
        
        function onWindowStylePreSet( obj, ~, ~ )
            
            obj.WindowStyle = obj.FigureObserver.Figure.WindowStyle;
            
        end % onWindowStylePreSet
        
        function onWindowStylePostSet( obj, ~, ~ )
            
            oldWindowStyle = obj.WindowStyle;
            newWindowStyle = obj.FigureObserver.Figure.WindowStyle;
            wasDocked = strcmp( oldWindowStyle, 'docked' );
            isDocked = strcmp( newWindowStyle, 'docked' );
            
            if ~wasDocked && isDocked
                
            elseif wasDocked && ~isDocked
                
            end
            
            % Set caches
            obj.WindowStyle = newWindowStyle;
            
        end % onWindowStylePostSet
        
        function onMouseMotion( obj, ~, ~ )
            
            % Identify whether pointer was and is over the subject
            wasOver = obj.MouseOver;
            isOver = obj.isMouseOver();
            
            % Raise enter or leave event
            if ~wasOver && isOver
                notify( obj, 'MouseEnter' )
            elseif wasOver && ~isOver
                notify( obj, 'MouseLeave' )
            end
            
            % Set caches
            obj.MouseOver = isOver;
            
            % Raise motion event
            if isOver
                notify( obj, 'MouseMotion' )
            end
            
        end % onMouseMotion
        
    end % event handlers
    
    methods
        
        function tf = isMouseOver( obj )
            
            % Initialize method
            persistent ROOT
            if isequal( ROOT, [] )
                % Disable JavaFrame warning
                warning( 'off', ...
                    'MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame' )
                % Cache root
                ROOT = groot();
            end
            
            % Get container
            subject = obj.Subject;
            
            % Get current point
            pointerLocation = ROOT.PointerLocation;
            figure = obj.FigureObserver.Figure;
            if strcmp( figure.WindowStyle, 'docked' )
                screenSize = ROOT.ScreenSize;
                figureSize = figure.Position(3:4);
                jFrame = figure.JavaFrame;
                jFigurePanelContainer = jFrame.getFigurePanelContainer();
                jFigureLocation = jFigurePanelContainer.getLocationOnScreen();
                figureOrigin = [jFigureLocation.getX(), screenSize(4) - ...
                    jFigureLocation.getY() - figureSize(2)];
            else
                figureOrigin = figure.Position(1:2) - [1 1];
            end
            currentPoint = pointerLocation - figureOrigin;
            
            % Get subject position
            position = getpixelposition( subject );
            
            % Is over?
            tf = currentPoint(1) >= position(1) && ...
                currentPoint(1) < position(1) + position(3) && ...
                currentPoint(2) >= position(2) && ...
                currentPoint(2) < position(2) + position(4);
            
        end % isMouseOver
        
    end % helpers
    
end % classdef