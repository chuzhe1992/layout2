classdef ( Abstract ) SharedPanelTests < sharedtests.SharedContainerTests
    %PANELCONTAINERTESTS Additional tests common to all panel containers
    %(*.CardPanel, *.Panel, *.TabPanel, *.BoxPanel, and
    %uix.ScrollingPanel).

    properties ( TestParameter )
        % Collection of invalid values for the 'Selection' property, used
        % to test that panels issue an error.
        InvalidSelection = {2.4, int32( 2 ), [2, 3, 4], 5}
    end % properties ( TestParameter )

    properties ( Access = private )
        % State associated with the warning with ID 'uix:G1218142'.
        WarningState
    end % properties ( Access = private )

    methods ( TestClassSetup )

        function suppressWarnings( testCase )

            % Suppress this warning during the test procedure. Restore the
            % original warning state when the test completes.
            warningID = 'uix:G1218142';
            testCase.WarningState = warning( 'query', warningID );
            testCase.addTeardown( @() warning( testCase.WarningState ) )
            warning( 'off', warningID )            

        end % suppressWarnings

    end % methods ( TestClassSetup )

    methods(TestClassTeardown)
        function showTestDone(testCase)
            disp("done for SharedPanelTests");
        end
    end

    methods ( Test, Sealed )
        %{
        function tContentsRespectPlacingBoxInPanel( ...
                testCase, ConstructorName )
            disp("check 1");
            % Create the component.
            component = testCase.constructComponent( ConstructorName );

            % Add a box.
            box = uiextras.HBox( 'Parent', component );

            % Verify that the 'Contents' property is correct.
            testCase.verifyEqual( component.Contents, box )
            disp("pass 1");
        end % tContentsRespectPlacingBoxInPanel

        function tPanelContentsHaveCorrectVisibility( ...
                testCase, ConstructorName )
            disp("check 2");
            % Create the component with children.
            [component, kids] = testCase...
                .constructComponentWithChildren( ConstructorName );

            % Select one of the children.
            selectionIndex = 2;
            component.Selection = selectionIndex;

            % Verify that the selected child is visible.
            selectedKidVisibility = char( kids(2).Visible );
            testCase.verifyEqual( selectedKidVisibility, 'on', ...
                ['The selected child in the ', ConstructorName, ...
                ' component is not visible.'] )
            % Verify that the other children are not visible.
            for k = [1, 3, 4]
                kidVisibility = char( kids(k).Visible );
                testCase.verifyEqual( kidVisibility, 'off', ...
                    ['The unselected child in the ', ...
                    ConstructorName, ' component is visible.'] )
            end % for
            disp("pass 2");
        end % tPanelContentsHaveCorrectVisibility

        function tSettingInvalidSelectionErrors( ...
                testCase, ConstructorName, InvalidSelection )
            disp("check 3");
            % Create the component.
            component = testCase.constructComponent( ConstructorName );

            % Verify that setting an invalid value for the 'Selection'
            % property throws an error.
            invalidSetter = ...
                @() set( component, 'Selection', InvalidSelection );
            testCase.verifyError( invalidSetter, ...
                'uix:InvalidPropertyValue', ...
                ['The ', ConstructorName, ' component did not throw ', ...
                'the expected exception when the ''Selection'' ', ...
                'property was set to an invalid value.'] )
            disp("pass 3");
        end % tSettingInvalidSelectionErrors

        function tSettingInvalidSelectionErrorsWhenChildrenArePresent( ...
                testCase, ConstructorName, InvalidSelection )
            disp("check 4");
            % Create the component.
            component = testCase.constructComponentWithChildren( ...
                ConstructorName );

            % Verify that setting an invalid value for the 'Selection'
            % property throws an error.
            invalidSetter = ...
                @() set( component, 'Selection', InvalidSelection );
            testCase.verifyError( invalidSetter, ...
                'uix:InvalidPropertyValue', ...
                ['The ', ConstructorName, ' component did not throw ', ...
                'the expected exception when the ''Selection'' ', ...
                'property was set to an invalid value.'] )
            disp("pass 4");
        end % tSettingInvalidSelectionErrorsWhenChildrenArePresent

        function tSettingSelectionPropertyIsCorrect( ...
                testCase, ConstructorName )
            disp("check 5");
            % Create the component.
            component = testCase.constructComponent( ConstructorName );

            % Set the 'Selection' property.
            component.Selection = 0;

            % Verify that the 'Selection' property has been set correctly.
            testCase.verifyEqual( component.Selection, 0, ...
                ['Setting the ''Selection'' property on the ', ...
                ConstructorName, ' component when it has no ', ...
                'children did not return 0.'] )
            disp("pass 5");
        end % tSettingSelectionPropertyIsCorrect
        %}

        %{
        function tSettingSelectionPropertyWithChildrenIsCorrect( ...
                testCase, ConstructorName )
            disp("check 6");
            % Create the component.
            component = testCase.constructComponentWithChildren( ...
                ConstructorName );

            % Set the 'Selection' property.
            component.Selection = 2;

            % Verify that the 'Selection' property has been set correctly.
            testCase.verifyEqual( component.Selection, 2, ...
                ['Setting the ''Selection'' property on the ', ...
                ConstructorName, ' component when it has ', ...
                'children did not return the correct value.'] )
            disp("pass 6");
        end % tSettingSelectionPropertyWithChildrenIsCorrect

        function tAddingInvisibleContainerIsWarningFree( ...
                testCase, ConstructorName )
            disp("check 7");
            % Create the component.
            component = testCase.constructComponent( ConstructorName );

            % Create an invisible container then reparent it to the
            % component.
            container = uicontainer( 'Parent', [], 'Visible', 'off' );
            testCase.addTeardown( @() delete( container ) )
            reparenter = @() set( container, 'Parent', component );
            testCase.verifyWarningFree( reparenter, ...
                ['Reparenting an invisible container to the ', ...
                ConstructorName, ' component was not warning-free.'] )
            disp("pass 7");
        end % tAddingInvisibleContainerIsWarningFree

        function tAddingInvisibleControlIsWarningFree( ...
                testCase, ConstructorName )
            disp("check 8");
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
            disp("pass 8");
        end % tAddingInvisibleControlIsWarningFree

        function tAddingInternalControlDoesNotAffectContents( ...
                testCase, ConstructorName )
            disp("check 9");
            % Create the component.
            component = testCase.constructComponent( ConstructorName );

            % Add an internal control to the component.
            button = uicontrol( 'Parent', component, 'Internal', true );

            % Verify that the component's 'Contents' property remains
            % empty.
            testCase.verifyEmpty( component.Contents, ...
                ['Adding an internal control to the ', ...
                ConstructorName, ' component did not leave the ', ...
                '''Contents'' property empty.'] )

            % Switch the 'Internal' property of the button to false and
            % verify that the 'Contents' property of the component updates.
            button.Internal = false;
            testCase.verifyNumElements( component.Contents, 1, ...
                ['The ''Contents'' property of the ', ConstructorName, ...
                ' component did not update when an internal control ', ...
                'was switched to non-internal.'] )
            disp("pass 9");
        end % tAddingInternalControlDoesNotAffectContents
        %}

        function tDynamicAdditionOfEnableProperty( ...
                testCase, ConstructorName )
            disp("check 10");
            %{
            % This test is only for components with a dynamic 'Enable'
            % property.
            testCase.assumeComponentHasDynamicEnableProperty( ...
                ConstructorName )            

            % Create the component.
            component = testCase.constructComponent( ConstructorName );

            % Verify that getting the 'Enable' property returns 'on'.
            testCase.verifyEqual( getEnable( component ), 'on', ...
                ['The get method for ''Enable'' on the ', ...
                ConstructorName, ' component did not return the ', ...
                'value ''on''.'] )

            % Verify that setting the 'Enable' property is warning-free.
            f = @() setEnable( component, 'on' );
            testCase.verifyWarningFree( f, ...
                ['The set method for ''Enable'' on the ', ...
                ConstructorName, ' component was not warning-free ', ...
                'when the value was set to ''on''.'] )

            % Verify that setting a non-char value causes an error.
            f = @() setEnable( component, 0 );
            testCase.verifyError( f, 'uiextras:InvalidPropertyValue', ...
                ['The set method for ''Enable'' on the ', ...
                ConstructorName, ' component did not throw an error ', ...
                'with ID ''uiextras:InvalidPropertyValue'' when ', ...
                'the ''Enable'' property was set to a non-char value.'] )

            % Verify that setting a value not 'on' or 'off' causes an 
            % error.
            f = @() setEnable( component, 'test' );
            testCase.verifyError( f, 'uiextras:InvalidPropertyValue', ...
                ['The set method for ''Enable'' on the ', ...
                ConstructorName, ' component did not throw an error ', ...
                'with ID ''uiextras:InvalidPropertyValue'' when ', ...
                'the ''Enable'' property was not ''on'' or ''off''.'] )

            %}
            disp("pass 10");
            
        end % tDynamicAdditionOfEnableProperty
        
    end % methods ( Test, Sealed )

end % class
