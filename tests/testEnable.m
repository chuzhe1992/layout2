function test_suite = testEnable()
%testEnable  Unit tests for enabling behavior
%
%   This test suite requires Steve Eddin's xUnit testing framework to be
%   installed. Get it from the <a href="http://www.mathworks.com/matlabcentral/fileexchange/22846">File Exchange</a>.
%
%   Type "runtests" to run the test suite.

%   Copyright 2010 The MathWorks Ltd.
%   $Revision: 294 $    
%   $Date: 2010-07-15 14:18:48 +0100 (Thu, 15 Jul 2010) $

%#ok<*DEFNU> (ignore the unused subfunction warnings)

% Intialise xUnit
initTestSuite();



function testSimpleEnable()
%ttestSimpleEnable  Test enabling behavior for uicontrols
close all force;
h = uiextras.HBox( 'Parent', figure(), 'ContentsEnable', 'on' );
controls = [
    uicontrol('Parent',h,'String','Button 1','Enable','on')
    axes('Parent',h)
    uicontrol('Parent',h,'String','Button 2','Enable','off')
    uicontrol('Parent',h,'String','Button 1','Enable','on')
    ];
% Test that our initial settings were honoured
assertEqual( get( controls(1), 'Enable' ), 'on' );
assertEqual( get( controls(3), 'Enable' ), 'off' );
assertEqual( get( controls(4), 'Enable' ), 'on' );
 
set(h,'ContentsEnable','off');
assertEqual( get( controls(1), 'Enable' ), 'off' );
assertEqual( get( controls(3), 'Enable' ), 'off' );
assertEqual( get( controls(4), 'Enable' ), 'off' );
 
set(h,'ContentsEnable','on');
% Make sure that anything previously disabled is still disabled
assertEqual( get( controls(1), 'Enable' ), 'on' );
assertEqual( get( controls(3), 'Enable' ), 'off' );
assertEqual( get( controls(4), 'Enable' ), 'on' );

close all force;

function testHierarchyEnable1()
%testHierarchyEnable1  Test enabling behavior for heirarchies of layouts
close all force;
h = uiextras.HBox( 'Parent', figure(), 'ContentsEnable', 'on' );
box1 = uiextras.BoxPanel('Parent',h,'Title','Panel 1','ContentsEnable','off');
control1 = uicontrol('Parent',box1,'String','Button 1');
box2 = uiextras.BoxPanel('Parent',h,'Title','Panel 2','ContentsEnable','on');
control2 = uicontrol('Parent',box2,'String','Button 1','Enable','off');

% Check that the right things are initially enabled
assertEqual( get( box1, 'ContentsEnable' ), 'off' );
assertEqual( get( box2, 'ContentsEnable' ), 'on' );
assertEqual( get( control1, 'Enable' ), 'off' );
assertEqual( get( control2, 'Enable' ), 'off' );

set(h,'ContentsEnable','off');
% Test that everything is initially off
assertEqual( get( box1, 'ContentsEnable' ), 'off' );
assertEqual( get( box2, 'ContentsEnable' ), 'on' );
assertEqual( get( control1, 'Enable' ), 'off' );
assertEqual( get( control2, 'Enable' ), 'off' );
 
set(h,'ContentsEnable','on');
% Check that the right things are now enabled
assertEqual( get( box1, 'ContentsEnable' ), 'off' );
assertEqual( get( box2, 'ContentsEnable' ), 'on' );
assertEqual( get( control1, 'Enable' ), 'off' );
assertEqual( get( control2, 'Enable' ), 'off' );

close all force;

function testHierarchyEnable2()
%testHierarchyEnable2  Test enabling behavior for heirarchies of layouts
v = uiextras.VBox( 'Parent', figure(), 'Enable','off');
h = uiextras.HBox( 'Parent', v, 'Enable', 'on');
b = uicontrol('Parent',h,'String','Button 1');
assertEqual( get(v,'Enable'), 'off' );
assertEqual( get(h,'Enable'), 'off' );
assertEqual( get(b,'Enable'), 'off' );
 
close all force;

 
function testHierarchyEnable3()
%testHierarchyEnable3  Test enabling behavior for uicontrols
v = uiextras.VBox( 'Parent', figure(), 'Enable','off' );
h = uiextras.HBox('Parent',v,'Enable','off');
b = uicontrol('Parent',h,'String','Button 1','Enable','on');
assertEqual( get(v,'Enable'), 'off' );
assertEqual( get(h,'Enable'), 'off' );
assertEqual( get(b,'Enable'), 'off' );

close all force;

function testHierarchyEnable4()
%testHierarchyEnable4  Test enabling behavior for heirarchies of layouts
v = uiextras.VBox( 'Parent', figure(), 'Enable', 'off' );
h = uiextras.HBox('Parent',v,'Enable','off');
b = uicontrol('Parent',h,'String','Button 1','Enable','off');
assertEqual( get(v,'Enable'), 'off' );
assertEqual( get(h,'Enable'), 'off' );
assertEqual( get(b,'Enable'), 'off' );

close all force;

function testHierarchyEnable5()
%testHierarchyEnable5  Test enabling behavior for heirarchies of layouts
v = uiextras.VBox( 'Parent', figure(), 'Enable', 'on' );
h = uiextras.HBox('Parent',v,'Enable','off');
b = uicontrol('Parent',h,'String','Button 1','Enable','off');
assertEqual( get(v,'Enable'), 'on' );
assertEqual( get(h,'Enable'), 'off' );
assertEqual( get(b,'Enable'), 'off' );

close all force;

function testHierarchyEnable6()
%testHierarchyEnable6  Test enabling behavior for heirarchies of layouts
v = uiextras.VBox( 'Parent', figure(), 'Enable', 'on' );
h = uiextras.HBox('Parent',v,'Enable','on');
b = uicontrol('Parent',h,'String','Button 1','Enable','off');
assertEqual( get(v,'Enable'), 'on' );
assertEqual( get(h,'Enable'), 'on' );
assertEqual( get(b,'Enable'), 'off' );

close all force;

function testHierarchyEnable7()
%testHierarchyEnable7  Test enabling behavior for heirarchies of layouts
v = uiextras.VBox( 'Parent', figure(), 'Enable', 'on' );
h = uiextras.HBox('Parent',v,'Enable','on');
b = uicontrol('Parent',h,'String','Button 1','Enable','on');
assertEqual( get(v,'Enable'), 'on' );
assertEqual( get(h,'Enable'), 'on' );
assertEqual( get(b,'Enable'), 'on' );

close all force;

function testHierarchyEnable8()
%testHierarchyEnable8  Test enabling behavior for heirarchies of layouts
v = uiextras.VBox( 'Parent', figure(), 'Enable', 'on' );
h = uiextras.HBox('Parent',v,'Enable','off');
b = uicontrol('Parent',h,'String','Button 1','Enable','on');
assertEqual( get(v,'Enable'), 'on' );
assertEqual( get(h,'Enable'), 'off' );
assertEqual( get(b,'Enable'), 'off' );

close all force;

function testHierarchyEnable9()
%testHierarchyEnable9  Test enabling behavior for heirarchies of layouts
v = uiextras.VBox( 'Parent', figure(), 'Enable', 'off' );
h = uiextras.BoxPanel('Parent',v,'Enable','on');
b = uicontrol('Parent',h,'String','Button 1','Enable','off');
assertEqual( get(v,'Enable'), 'off' );
assertEqual( get(h,'Enable'), 'off' );
assertEqual( get(b,'Enable'), 'off' );

close all force;