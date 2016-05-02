# React stuff
React = require 'react'
ReactDOM = require 'react-dom'
createLogger = require 'redux-logger'
loggerMiddleware = createLogger(
  level: 'log'
  duration: true
  collapsed: true
)

require './assets/css/ecb.css'
require './assets/css/select2-bootstrap.min.css'

# Redux actions
csActions = require './actions/cs-actions'
fltrActions = require './actions/fltr-actions'
hclActions = require './actions/hcl-actions'

# Redux reducers
{categories} = require('./reducers/cs-reducers')
{dataflows} = require('./reducers/df-reducers')
{filters} = require('./reducers/fltr-reducers')
{hierarchies} = require('./reducers/hcl-reducers')

# Redux container
{WizardContainer} = require('./components/wizard/container')

# Redux core
{createStore, applyMiddleware, combineReducers} = require 'redux'
{Provider} = require 'react-redux'
thunkMiddleware = require('redux-thunk').default

sdmxrest = require 'sdmx-rest'

reducers = combineReducers {categories, dataflows, filters, hierarchies}
store = createStore reducers, applyMiddleware thunkMiddleware, loggerMiddleware

hQuery =
  resource: 'hierarchicalcodelist'
  id: 'HCL_COUNTRY_GROUPINGS'
  agency: 'ECB.DISS'
hUrl = sdmxrest.getUrl hQuery, 'ECB_S'
store.dispatch hclActions.fetchHCL hUrl

csQuery =
  resource: 'categoryscheme'
  id: 'MOBILE_NAVI_PUB'
  agency: 'ECB.DISS'
  references: 'parentsandsiblings'
csUrl = sdmxrest.getUrl csQuery, 'ECB_S'
store.dispatch csActions.fetchCS csUrl

provider = React.createElement Provider, { store },
  <div className="container">
    <div className="row clearfix">
      <div className="col-xs-3 col-sm-4 col-md-6 col-lg-6">
        <img src="http://sdmx.org/wp-content/uploads/sdmx-logo_2.png"/>
      </div>
      <div className="col-xs-9 col-sm-8 col-md-6 col-lg-6 text-right">
        <h4 className="title text-primary">ECB SDMX Web Data Connectors <small>ECB Public Statistical Data Warehouse</small></h4>
      </div>
    </div>
    <WizardContainer id="wdc-app"/>
  </div>

app = document.createElement 'div'
app.className = "fuelux"
document.body.appendChild app
ReactDOM.render provider, app
