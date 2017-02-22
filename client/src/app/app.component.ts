import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  //title = 'app works3!';
  username: string = '';
  password: string = '';

  redirect()
  {
    this.username = 'working';
  }
}
