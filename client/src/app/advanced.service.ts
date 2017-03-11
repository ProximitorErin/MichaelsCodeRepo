import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/Observable';
import { IAverageStat } from './average-stat';
import { Http, Response } from '@angular/http';

@Injectable()
export class AdvancedService {

  constructor(private _http: Http) { }

  getSportAverages() : Observable<IAverageStat[]>
  {
    return this._http.get(this._advancedSql1Url)
      .map((response: Response) => <IAverageStat[]>response.json())
      .do(data => console.log('All: ' + JSON.stringify(data)))
      .catch(this.handleError);
  }

  private handleError(error: Response)
  {
    console.error('tournament service error:' + error);
    return Observable.throw(error.json().error || 'Server error');
  }

  private _advancedSql1Url = '/getCurrentSportAverages';

}
