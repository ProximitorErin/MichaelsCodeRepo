import { Component, OnInit } from '@angular/core';
import { IStatistic } from '../statistic';
import { TournamentsService } from '../tournaments.service';
import { AdvancedService } from '../advanced.service';

@Component({
  selector: 'app-single-stat',
  templateUrl: './single-stat.component.html',
  styleUrls: ['./single-stat.component.css']
})
export class SingleStatComponent implements OnInit {

  constructor(private _tournamentService : TournamentsService, private _advancedService : AdvancedService) { }

  ngOnInit() {
    if (this.availableStatistics == null)
    {
      this._tournamentService.getStatsForDates("2017-02-24", "2017-3-3")
        .subscribe(
          availableStats => this.availableStatistics = availableStats,
          error => this.errorMessage = <any>error
        );
    }
  }

  analyzeStat(): void
  {
    var sportName1: string = this.sel1.split('--')[0];
    var statName1: string = this.sel1.split('--')[1];
    var sportName2: string = this.sel2.split('--')[0];
    var statName2: string = this.sel2.split('--')[1];

    this._advancedService.getSingleAverage(sportName1, statName1, sportName2, statName2)
      .subscribe(
        answer => this.answer = answer,
        error => this.errorMessage = <any>error
      );
  }

  answer: string = '<pending>';
  availableStatistics: IStatistic[] = null;
  errorMessage: string;
  sel1: string = '';
  sel2: string = '';

}
