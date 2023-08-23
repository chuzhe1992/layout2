classdef tSimpleTest < glttestutilities.TestInfrastructure
    %TBOXPANEL Tests for uiextras.BoxPanel and uix.BoxPanel.

    properties ( TestParameter )
        % The constructor name, or class, of the component under test.
        ConstructorName = {'uiextras.BoxPanel', 'uix.BoxPanel'}
    end 

    methods ( Test, Sealed )

        %{
        function dummyTestPoint( ...
                testCase, ConstructorName )

            disp("---check here----");

            disp("---pass check---");

        end 
        %}
        
         function tAddingInvisibleControlIsWarningFree(testCase, ConstructorName )
            disp("check 2");
            % Create the component.
            component = testCase.constructComponent( ConstructorName );

            % Create an invisible control then reparent it to the
            % component.
            button = uicontrol( 'Parent', [], 'Visible', 'off' );
            testCase.addTeardown( @() delete( button ) )
            reparenter = @() set( button, 'Parent', component );
            testCase.verifyWarningFree( reparenter, ...
                ['Reparenting an invisible control to the ', ...
                ConstructorName, ' component was not warning-free.'] )            
            disp("pass 2");
        end 

  end

end
