import { Component, OnInit } from '@angular/core';
import { TournamentsService } from '../tournaments.service';
import { IAthlete } from '../Athlete';

@Component({
  selector: 'app-athlete-selection',
  templateUrl: './athlete-selection.component.html',
  styleUrls: ['./athlete-selection.component.css']
})
export class AthleteSelectionComponent implements OnInit {

  formatResult(data)
  {
      this.athletes = data;
      this.slides = [];
      for (let athlete of this.athletes) {
        this.slides.push(athlete);
      }
  }

  constructor(private _tournamentService : TournamentsService) {
    
   }

   athletes: IAthlete[];
  errorMessage: string;

  ngOnInit() {
    this._tournamentService.getAthletes()
      .subscribe(
        data => this.formatResult(data),
        error => this.errorMessage = <any>error
      );
    //this.addNewSlide();
  }

  //The time to show the next photo
    private NextPhotoInterval:number = 3000;
    //Looping or not
    private noLoopSlides:boolean = false;
    //Photos
    private slides:Array<any> = [];

  private addNewSlide() {
         this.slides.push(
            {image:'http://www.fightingillini.com/images/2016/12/16/Brochu_Danielle_2MJ0732.jpg?width=182&height=250&scale=both&bgcolor=e84a27',text:'Danielle Brochu'},
            {image:'http://www.fightingillini.com/images/2016/12/16/Gunther_Alyssa_2MJ0750.jpg?width=182&height=250&scale=both&bgcolor=e84a27',text:'Alyssa Gunther'},
            {image:'http://www.fightingillini.com/images/2016/12/16/Carrillo_Alexis_2MJ0718.jpg?width=182&height=250&scale=both&bgcolor=e84a27',text:'Alexis Carrillo'}
        );
    }

}
