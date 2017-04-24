import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/map';
import 'rxjs/add/operator/do';
import 'rxjs/add/operator/catch';
import { ITournament } from './tournament';
import { IStatistic } from './statistic';
import { IAthlete } from './athlete';
import { ITeam } from './team';

@Injectable()
export class TournamentsService {

  private _tournamentsUrl = '/getTournaments';
  private _statsUrl = '/getStatsByDate';
  private _createUrl = '/createTournamentService';
  private _deleteUrl = '/deleteTournament';
  private _incrementUrl = '/increaseTeamCountByOne';
  private _athletesUrl = '/getAthletes';
  private _joinUrl = '/joinTournament';
  private _teamsUrl = '/getTeamsFor';

  constructor(private _http: Http) { }

  incrementTournament(name: string, start: string, end: string)
  {
    return this._http.get(this._incrementUrl + '?name=' + name +
      '&start=' + start +
      '&end=' + end)
      .map((response: Response) => <string>response.text())
      .do(data => console.log('All: ' + data))
      .catch(this.handleError);
  }

  joinTournament(name: string, start: string, end: string, username:string)
  {
    return this._http.get(this._joinUrl + '?name=' + name +
      '&start=' + start +
      '&end=' + end +
      '&username=' + username)
      .map((response: Response) => <string>response.text())
      .do(data => console.log('All: ' + data))
      .catch(this.handleError);
  }
  getTeamsFor(username: string)
  {
    return this._http.get(this._teamsUrl + '?username='+ username)
    .map((response: Response) => <string>response.text())
    .do(data => console.log('All: ' + data))
    .catch(this.handleError);
  }

  deleteTournament(name: string, start: string, end: string)
  {
    return this._http.get(this._deleteUrl + '?name=' + name +
      '&start=' + start +
      '&end=' + end)
      .map((response: Response) => <string>response.text())
      .do(data => console.log('All: ' + data))
      .catch(this.handleError);
  }

  createTournament(name: string, start: string, end: string, size: number, count: number, stats: IStatistic[], username: string)
  {
    return this._http.get(this._createUrl + '?name=' + name +
      '&start=' + start +
      '&end=' + end +
      '&size=' + size +
      '&count=' + count +
      '&username=' + username +
      '&stats=' + JSON.stringify(stats))
      .map((response: Response) => <string>response.text())
      .do(data => console.log('All: ' + data))
      .catch(this.handleError);
  }

  getStatsForDates(start: string, end: string) : Observable<IStatistic[]>
  {
    return this._http.get(this._statsUrl + '?startDate=' + start + '&endDate=' + end)
      .map((response: Response) => <IStatistic[]>response.json())
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

  getAthletes() : Observable<IAthlete[]>
  {
    return this._http.get(this._athletesUrl)
      .map((response: Response) => <IAthlete[]>response.json())
      .do(data => console.log('All: ' + JSON.stringify(data)))
      .catch(this.handleError);
  }

}
