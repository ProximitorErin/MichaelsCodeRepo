import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Observable } from 'rxjs/Observable';
import { IDailyStatForAthlete } from './dailyStatForAthlete';

import { LineChartDemoComponentComponent } from './line-chart-demo-component/line-chart-demo-component.component';

@Injectable()
export class AthletePerformanceService {

  private _statsUrl = '/getDailyStatsByAthlete';

  charter: LineChartDemoComponentComponent;

  constructor(private _http: Http) { }

  getAthleteStatsByDate(id:number)
  {
    return this._http.get(this._statsUrl + '?id='+id)
      .map((response: Response) => <IDailyStatForAthlete[]>response.json())
      .do(data => console.log('All: ' + JSON.stringify(data)))
      .catch(this.handleError);
  }

  private handleError(error: Response)
  {
    console.error('tournament service error:' + error);
    return Observable.throw(error.json().error || 'Server error');
  }

}
