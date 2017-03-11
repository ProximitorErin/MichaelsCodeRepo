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

  getSingleAverage(sportName1: string, statName1: string, sportName2: string, statName2: string)
  {
      return this._http.get(this._advancedSql2Url+ '?sport1=' + sportName1 +
        '&stat1=' + statName1 +
        '&sport2=' + sportName2 +
        '&stat2=' + statName2)
        .map((response: Response) => <string>response.text())
        .do(data => console.log('All: ' + data))
        .catch(this.handleError);
  }

  private handleError(error: Response)
  {
    console.error('tournament service error:' + error);
    return Observable.throw(error.json().error || 'Server error');
  }

  private _advancedSql1Url = '/getCurrentSportAverages';
  private _advancedSql2Url = '/getSingleAverage';

}
