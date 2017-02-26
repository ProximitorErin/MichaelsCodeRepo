import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { DialogComponent } from '../dialog/dialog.component';
import { IStatistic } from '../statistic';
import { TournamentsService } from '../tournaments.service';

@Component({
  selector: 'app-tournament-creation',
  templateUrl: './tournament-creation.component.html',
  styleUrls: ['./tournament-creation.component.css']
})
export class TournamentCreationComponent implements OnInit {

  constructor(private _router: Router, private _tournamentService : TournamentsService) { }

  ngOnInit() {
  }

  addStat(): void
  {
    var sportName: string = this.sel1.split('--')[0];
    var statName: string = this.sel1.split('--')[1];

    this.chosenStatistics = this.chosenStatistics.concat([
    {
        "sportName" : sportName,
        "statName" : statName,
        "weight" : this.statWeight
    }
    ]);

    for (var i = this.availableStatistics.length - 1; i >= 0; i--) {
      if (this.availableStatistics[i].sportName == sportName && this.availableStatistics[i].statName == statName) { 
        this.availableStatistics.splice(i, 1);
      }
    }
    this.sel1 = '';
    this.statWeight = null;

    console.log('clicked');
    this.showDialog = !this.showDialog;

  }
  
  showAddStat(): void
  {
    if (this.availableStatistics == null)
    {
      this._tournamentService.getStatsForDates(this.tournamentStartDate, this.tournamentEndDate)
        .subscribe(
          availableStats => this.availableStatistics = availableStats,
          error => this.errorMessage = <any>error
        );
    }
    this.showDialog = !this.showDialog;
  }

  deleteStat(): void
  {
    //todo
  }

  submit(): void
  {
    this._tournamentService.createTournament(this.tournamentName, this.tournamentStartDate, 
      this.tournamentEndDate, this.teamSize, this.teamCount, this.chosenStatistics)
        .subscribe(
          data => this.formatResult(data),
          error => this.errorMessage = <any>error
        );


    console.log('vals: ' + this.tournamentName + this.tournamentStartDate + this.tournamentEndDate + 
    this.teamCount + this.teamSize + this.sel1 + this.statWeight);
  }

  formatResult(result)
  {
    this.answer = result;
    
    if (this.answer.indexOf("success") > -1)
    {
      this._router.navigate(['administrator']);
    }
  }

  showDialog = false;

  tournamentName: string = '';
  tournamentStartDate: string = '';
  tournamentEndDate: string = '';
  teamSize: number;
  teamCount: number;
  sel1: string = '';
  statWeight: number;
  errorMessage: string;
  answer: string;

  chosenStatistics: IStatistic[] = [];

  availableStatistics: IStatistic[] = null;

}
