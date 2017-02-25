import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/do';
import 'rxjs/add/operator/catch';
import { ITournament } from './tournament';
import { IStatistic } from './statistic';

@Injectable()
export class TournamentsService {

  private _tournamentsUrl = '/getTournaments';
  private _statsUrl = '/getStatsByDate';
  private _createUrl = '/createTournamentService';

  constructor(private _http: Http) { }

  createTournament(name: string, start: string, end: string, size: number, count: number, stats: IStatistic[])
  {
    return this._http.get(this._createUrl + '?name=' + name +
      '&start=' + start +
      '&end=' + end +
      '&size=' + size +
      '&count=' + count +
      '&stats=' + stats)
      .map((response: Response) => <string>response.json())
      .do(data => console.log('All: ' + JSON.stringify(data)))
      .catch(this.handleError);
  }

  getStatsForDates(start: string, end: string) : Observable<IStatistic[]>
  {
    return this._http.get(this._statsUrl + '?startDate=' + start + '&endDate=' + end)
      .map((response: Response) => JSON.stringify(<IStatistic[]>response.json()))
      .do(data => console.log('All: ' + JSON.stringify(data)))
      .catch(this.handleError);
  }

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
