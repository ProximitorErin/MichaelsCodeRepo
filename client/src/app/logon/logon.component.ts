import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AuthenticationService } from '../authentication.service';

@Component({
  selector: 'app-logon',
  templateUrl: './logon.component.html',
  styleUrls: ['./logon.component.css']
})
export class LogonComponent implements OnInit {

  ngOnInit() {
  }

  constructor(private _router: Router, private _authService: AuthenticationService) { }

  username: string = '';
  password: string = '';
  role: string = '';
  errorMessage: any;

  redirect(): void
  {
    this._authService.getRole(this.username, this.password)
      .subscribe(
        data => this.formatResult(data),
        error => this.errorMessage = <any>error);
      
    /* if (this._authService.getRole() == 'admin')
    {
      this._router.navigate(['administrator']);
    }*/
  }

  formatResult(result)
  {
    this.role = result;
    if (this.role == 'admin')
    {
      this._router.navigate(['administrator']);
    }
  }

}
