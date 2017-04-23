import { Component, OnInit } from '@angular/core';
import { AuthenticationService } from '../authentication.service';
import { TournamentsService } from '../tournaments.service';

@Component({
  selector: 'app-administrator',
  templateUrl: './administrator.component.html',
  styleUrls: ['./administrator.component.css']
})
export class AdministratorComponent implements OnInit {

  constructor(private _auth: AuthenticationService, private _tournamentService: TournamentsService) { }

  ngOnInit() {
    this._tournamentService.getTeamsFor(this._auth.getUsername())
    .subscribe(
      teams => this.teams = teams,
      error => this.errorMessage = <any>error
    );
  }

  teams: ITeam[] = null;
  errorMessage: string;

}
