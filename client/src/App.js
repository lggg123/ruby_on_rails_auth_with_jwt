import React, { Component } from 'react';
import axios from 'axios'
import {BrowserRouter, Switch, Route} from 'react-router-dom'


class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      isLoggedIn: false,
      user: {}
    };
  };
  render() {
    return (
      <div className="App">
        <BrowserRouter>
          <Switch>
            <Route exact path='/' component={}/>
            <Route exact path='/login' component={} />
            <Route exact path='/register' component={} />
          </Switch>
        </BrowserRouter>
      </div>
    );
  }
};

export default App;
