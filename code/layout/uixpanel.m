function obj = uixpanel( varargin )

% Check inputs
uix.pvchk( varargin )

% Construct
obj = uix.Panel( varargin{:} );

% Auto-parent
if ~ismember( 'Parent', varargin(1:2:end) )
    obj.Parent = gcf();
end

end % uixpanel