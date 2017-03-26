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

  getAthleteStatsByDate(id:number): Observable<IDailyStatForAthlete[]> {
    return this._http.get(this._statsUrl + '?id=' + id)
                    .map(this.extractData)
                    .catch(this.handleError);
  }

  private extractData(res: Response) {
    console.log("aaa");
    let body = res.json();
    console.log("bbb" + body);
    return body || { };
  }

  private handleError(error: Response)
  {
    console.error('tournament service error:' + error);
    return Observable.throw(error.json().error || 'Server error');
  }

}
