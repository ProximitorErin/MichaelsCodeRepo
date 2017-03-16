import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';
import { RouterModule } from '@angular/router';

import { AppComponent } from './app.component';
import { AdministratorComponent } from './administrator/administrator.component';
import { LogonComponent } from './logon/logon.component';
import { AuthenticationService } from './authentication.service';
import { AdvancedService } from './advanced.service';
import { TournamentsService } from './tournaments.service';
import { TournamentListComponent } from './tournament-list/tournament-list.component';
import { TournamentCreationComponent } from './tournament-creation/tournament-creation.component';
import { DialogComponent } from './dialog/dialog.component';
import { TournamentUpdateComponent } from './tournament-update/tournament-update.component';
import { PlayerComponent } from './player/player.component';
import { CurrentSportAveragesListComponent } from './current-sport-averages-list/current-sport-averages-list.component';
import { SingleStatComponent } from './single-stat/single-stat.component';
import { AthleteSelectionComponent } from './athlete-selection/athlete-selection.component';
import { Carousel } from './carousel/carousel.component';
import { Slide } from './slide/slide.component';

@NgModule({
  declarations: [
    AppComponent,
    AdministratorComponent,
    LogonComponent,
    TournamentListComponent,
    TournamentCreationComponent,
    DialogComponent,
    TournamentUpdateComponent,
    PlayerComponent,
    CurrentSportAveragesListComponent,
    SingleStatComponent,
    AthleteSelectionComponent,
    Carousel,
    Slide
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    RouterModule.forRoot([
      { path: 'updateTournament', component: TournamentUpdateComponent },
      { path: 'createTournament', component: TournamentCreationComponent },
      { path: 'administrator', component: AdministratorComponent },
      { path: 'listTournaments', component: TournamentListComponent },
      { path: 'player', component: PlayerComponent },
      { path: 'listCurrentSportAverages', component: CurrentSportAveragesListComponent }, 
      { path: 'singleStat', component: SingleStatComponent },
      { path: 'athlete-selection', component: AthleteSelectionComponent },
      { path: '', component: LogonComponent }
    ])
  ],
  providers: [ AuthenticationService, TournamentsService, AdvancedService ],
  bootstrap: [AppComponent]
})
export class AppModule { }
