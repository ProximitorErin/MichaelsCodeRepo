import { Component, OnInit } from '@angular/core';
import { TournamentsService } from '../tournaments.service';
import { Observable } from 'rxjs/Observable';
import { ITournament } from '../tournament';
import { AuthenticationService } from '../authentication.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-tournament-list',
  templateUrl: './tournament-list.component.html',
  styleUrls: ['./tournament-list.component.css']
})
export class TournamentListComponent implements OnInit {

  constructor(private _tournamentService : TournamentsService, private _auth : AuthenticationService, private _router : Router) {

   }
  

  formatResult(result)
  {
    this.answer = result;

    this._tournamentService.getTournaments()
      .subscribe(
        tournaments => this.tournaments = tournaments,
        error => this.errorMessage = <any>error
      );
  }

   delete(tournament: ITournament): void
   {
     console.log("got delete!");
     console.log(tournament);

     this._tournamentService.deleteTournament(tournament.name, tournament.startDate, 
      tournament.endDate)
        .subscribe(
          data => this.formatResult(data),
          error => this.errorMessage = <any>error
        );


    console.log('vals: ' + tournament.name, tournament.startDate, 
      tournament.endDate, tournament.teamSize, tournament.teamCount, this._auth.getUsername());
   }

   addOne(tournament: ITournament): void
   {
     console.log("got addOne!");
     console.log(tournament);

     this._tournamentService.incrementTournament(tournament.name, tournament.startDate, 
      tournament.endDate)
        .subscribe(
          data => this.formatResult(data),
          error => this.errorMessage = <any>error
        );

   }

   join(tournament: ITournament): void
   {
     console.log("got join!");
     console.log(tournament);

     this._tournamentService.joinTournament(tournament.name, tournament.startDate, 
      tournament.endDate, this._auth.getUsername())
        .subscribe(
          data => this.formatResult(data),
          error => this.errorMessage = <any>error
        );

   }
   showAddPlayers(): void
   {
     this.showDialog = !this.showDialog;
   }
   addPlayers(): void{
     this.showDialog = !this.showDialog;
   }

  ngOnInit() {
    this._tournamentService.getTournaments()
      .subscribe(
        tournaments => this.tournaments = tournaments,
        error => this.errorMessage = <any>error
      );
  }

  tournaments: ITournament[];
  errorMessage: string;
  answer: string;

  showDialog = false;

}
