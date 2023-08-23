classdef tSimpleTest < glttestutilities.TestInfrastructure

    methods ( Test, Sealed )

         function tAddingInvisibleControlIsWarningFree(testCase )

            %ConstructorName = 'uiextras.BoxPanel'; % doesnt matter choosing 'uiextras.BoxPanel' or 'uix.BoxPanel'

            % Create the component.
            component = testCase.constructComponent(ConstructorName); 

            % Create an invisible control then reparent it to the
            % component.
            %button = uicontrol( 'Parent', [], 'Visible', 'off' );
            %testCase.addTeardown( @() delete( button ) )
            %reparenter = @() set( button, 'Parent', component );
            %testCase.verifyWarningFree( reparenter, ...
            %    ['Reparenting an invisible control to the ', ...
            %    ConstructorName, ' component was not warning-free.'] )            
        end 

  end

end
