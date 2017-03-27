import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Observable } from 'rxjs/Observable';
import { IDailyStatForAthlete } from './dailyStatForAthlete';

import { LineChartDemoComponentComponent } from './line-chart-demo-component/line-chart-demo-component.component';

@Injectable()
export class AthletePerformanceService {

  private _statsUrl = '/getDailyStatsByAthlete';

  charter: LineChartDemoComponentComponent;
  idx: number;

  constructor(private _http: Http) { }

  getAthleteStatsByDate(): Observable<IDailyStatForAthlete[]> {
    console.log("idx: " + this.idx);
    return this._http.get(this._statsUrl + '?id=' + this.idx + 1)
                    .map(this.extractData)
                    .catch(this.handleError);
  }

  setIndex(index:number)
  {
    this.idx = index;
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
