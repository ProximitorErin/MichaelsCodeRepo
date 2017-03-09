import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/do';
import 'rxjs/add/operator/catch';

@Injectable()
export class AuthenticationService {

  private _authUrl = '/login';
  private _username : string;

  constructor(private _http: Http) { }

  getUsername() : string
  {
    return this._username;
  }

  getRole(username: string, password: string) : Observable<string>
  {
    this._username = username;

    return this._http.get(this._authUrl + '?username=' + username + '&password=' + password)
      .map((response: Response) => <string>response.text())
      .do(data => console.log('All: ' + JSON.stringify(data)))
      .catch(this.handleError);
  }

  private handleError(error: Response)
  {
    console.error(error);
    return Observable.throw(error.json().error || 'Server error');
  }

}
