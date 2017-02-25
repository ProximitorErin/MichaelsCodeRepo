import { Component, OnInit } from '@angular/core';
import { DialogComponent } from '../dialog/dialog.component';

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

}
