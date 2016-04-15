# React stuff
React = require 'react'
ReactDOM = require 'react-dom'

require './assets/css/ecb.css'
require './assets/css/select2-bootstrap.min.css'

# Redux actions
csActions = require './actions/cs-actions'
fltrActions = require './actions/fltr-actions'

# Redux reducers
{categories} = require('./reducers/cs-reducers')
{dataflows} = require('./reducers/df-reducers')
{filters} = require('./reducers/fltr-reducers')

# Redux container
{WizardContainer} = require('./components/wizard/WizardContainer')

# Redux core
{createStore, applyMiddleware, combineReducers} = require 'redux'
{Provider} = require 'react-redux'
thunkMiddleware = require('redux-thunk').default

data = require '../test/fixtures/data.json'

populateStore = (store) ->
  store.dispatch csActions.csLoaded [data]

reducers = combineReducers {categories, dataflows, filters}
store = createStore reducers, applyMiddleware thunkMiddleware
populateStore store

provider = React.createElement Provider, { store },
  <div className="container">
    <div className="row clearfix">
      <div className="col-xs-3 col-sm-4 col-md-6 col-lg-6">
        <img src="http://sdmx.org/wp-content/uploads/sdmx-logo_2.png"/>
      </div>
      <div className="col-xs-9 col-sm-8 col-md-6 col-lg-6 text-right">
        <h4 className="title text-primary">ECB SDMX Web Data Connectors <small>Bringing SDMX data into Tableau</small></h4>
      </div>
    </div>
    <div id="wdc-app">
      <WizardContainer/>
    </div>
  </div>

app = document.createElement 'div' 
app.className = "fuelux"
document.body.appendChild app 
ReactDOM.render provider, app
