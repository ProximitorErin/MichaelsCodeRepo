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
    console.error(error);
    return Observable.throw(error.json().error || 'Server error');
  }

  /* getTournamentsBAD() : any[]
  {
    return [
      {
        "Name" : "The Big Smackdown",
        "StartDate" : "3/4/2017",
        "EndDate" : "5/1/2017",
        "TeamSize" : 5,
        "TeamCount" : 10,
        "Username" : "derek"
      },
      {
        "Name" : "April Foolishness",
        "StartDate" : "4/1/2017",
        "EndDate" : "6/1/2017",
        "TeamSize" : 7,
        "TeamCount" : 3,
        "Username" : "michael"
      }
    ];
  } */

}
