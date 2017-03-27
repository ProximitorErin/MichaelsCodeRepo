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
    var tmp: number;
    tmp = this.idx + 1;
    return this._http.get(this._statsUrl + '?id=' + tmp)
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
    if (body.length == 0)
    {
      console.log("ccc");
      return [
        {"data":[0,0,0,0,0,0,0,0,0,0,0,0],"label":"assists"},
        {"data":[0,0,0,0,0,0,0,0,0,0,0,0],"label":"atBats"},
        {"data":[0,0,0,0,0,0,0,0,0,0,0,0],"label":"hits"},
        {"data":[0,0,0,0,0,0,0,0,0,0,0,0],"label":"leftonbase"},
        {"data":[0,0,0,0,0,0,0,0,0,0,0,0],"label":"putouts"},
        {"data":[0,0,0,0,0,0,0,0,0,0,0,0],"label":"rbis"},
        {"data":[0,0,0,0,0,0,0,0,0,0,0,0],"label":"runs"},
        {"data":[0,0,0,0,0,0,0,0,0,0,0,0],"label":"strikeouts"}
      ];
    }
    console.log("ddd");
    return body || { };
  }

  private handleError(error: Response)
  {
    console.error('tournament service error:' + error);
    return Observable.throw(error.json().error || 'Server error');
  }

}
