import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/do';
import 'rxjs/add/operator/catch';
import { ITournament } from './tournament';

@Injectable()
export class TournamentsService {

  private _tournamentsUrl = '/getTournaments'

  constructor(private _http: Http) { }

  getTournaments() : Observable<ITournament[]>
  {
    return this._http.get(this._tournamentsUrl)
      .map((response: Response) => <ITournament[]>response.json())
      .do(data => console.log('All: ' + JSON.stringify(data)))
      .catch(this.handleError);
  }

  private handleError(error: Response)
  {
    console.error('tournament service error:' + error);
    return Observable.throw(error.json().error || 'Server error');
  }

}
