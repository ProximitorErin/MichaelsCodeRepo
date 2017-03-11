import { Component, OnInit } from '@angular/core';
import { IStatistic } from '../statistic';
import { TournamentsService } from '../tournaments.service';

@Component({
  selector: 'app-single-stat',
  templateUrl: './single-stat.component.html',
  styleUrls: ['./single-stat.component.css']
})
export class SingleStatComponent implements OnInit {

  constructor(private _tournamentService : TournamentsService) { }

  ngOnInit() {
    if (this.availableStatistics == null)
    {
      this._tournamentService.getStatsForDates("01/01/2001", "12/31/2099")
        .subscribe(
          availableStats => this.availableStatistics = availableStats,
          error => this.errorMessage = <any>error
        );
    }
  }

  availableStatistics: IStatistic[] = null;
  errorMessage: string;
  
}
