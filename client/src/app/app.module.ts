import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';
import { RouterModule } from '@angular/router';

import { AppComponent } from './app.component';
import { AdministratorComponent } from './administrator/administrator.component';
import { LogonComponent } from './logon/logon.component';
import { AuthenticationService } from './authentication.service';
import { TournamentsService } from './tournaments.service';
import { TournamentListComponent } from './tournament-list/tournament-list.component';
import { TournamentCreationComponent } from './tournament-creation/tournament-creation.component';
import { DialogComponent } from './dialog/dialog.component';

@NgModule({
  declarations: [
    AppComponent,
    AdministratorComponent,
    LogonComponent,
    TournamentListComponent,
    TournamentCreationComponent,
    DialogComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    RouterModule.forRoot([
      { path: 'createTournament', component: TournamentCreationComponent },
      { path: 'administrator', component: AdministratorComponent },
      { path: 'listTournaments', component: TournamentListComponent },
      { path: '', component: LogonComponent }
    ])
  ],
  providers: [ AuthenticationService, TournamentsService ],
  bootstrap: [AppComponent]
})
export class AppModule { }
