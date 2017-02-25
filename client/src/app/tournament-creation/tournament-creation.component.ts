import { Component, OnInit } from '@angular/core';
import { DialogComponent } from '../dialog/dialog.component';
import { IStatistic } from '../statistic';

@Component({
  selector: 'app-tournament-creation',
  templateUrl: './tournament-creation.component.html',
  styleUrls: ['./tournament-creation.component.css']
})
export class TournamentCreationComponent implements OnInit {

  constructor() { }

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

  deleteStat(): void
  {

  }

  redirect(): void
  {
    console.log('vals: ' + this.tournamentName + this.tournamentStartDate + this.tournamentEndDate + 
    this.teamCount + this.teamSize + this.sel1 + this.statWeight);
  }

  showDialog = false;

  tournamentName: string = '';
  tournamentStartDate: string = '';
  tournamentEndDate: string = '';
  teamSize: number;
  teamCount: number;
  sel1: string = '';
  statWeight: number;

  chosenStatistics: IStatistic[] = [];

  availableStatistics: IStatistic[] = [
      {
        "sportName" : "Football",
        "statName" : "Touchdown",
        "weight" : null
      },
      {
        "sportName" : "Soccer",
        "statName" : "Goal",
        "weight" : null
      }
    ];

}
