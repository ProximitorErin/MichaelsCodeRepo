import { Component, OnInit } from '@angular/core';
import { TournamentsService } from '../tournaments.service';
import { Observable } from 'rxjs/Observable';
import { ITournament } from '../tournament';

@Component({
  selector: 'app-tournament-list',
  templateUrl: './tournament-list.component.html',
  styleUrls: ['./tournament-list.component.css']
})
export class TournamentListComponent implements OnInit {

  constructor(private _tournamentService : TournamentsService) {

   }

   delete(tournamentName): void
   {
     console.log("got delete " + tournamentName);
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

}
