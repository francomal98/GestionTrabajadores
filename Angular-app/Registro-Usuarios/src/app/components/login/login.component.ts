import { HttpErrorResponse } from '@angular/common/http';
import { Component, OnDestroy, OnInit } from '@angular/core';
import { FormGroup, FormControl, FormBuilder, Validators } from '@angular/forms';
import { Subscription } from 'rxjs';
import { AccountLogin, LoginResponse } from 'src/app/models/Account/account-model';
import { AccountService } from 'src/app/services/account/account.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit, OnDestroy {
  formLogin: FormGroup = new FormGroup({})
  suscriptions: Subscription[] = []
  loginResponse = {} as LoginResponse
  validUser: boolean = true
  touchInput: boolean = false

  constructor(private _formBuilder: FormBuilder, private _accountServ: AccountService){
    this.formLogin = _formBuilder.group({
      username: ['', Validators.required],
      password: ['', Validators.required]
    })
  }

  ngOnInit(): void {}

  ngOnDestroy(): void {}

  login(){
    if(!this.formLogin.controls["username"].valid){
      this.validUser = false
      return
    }

    if(!this.formLogin.controls["password"].valid){
      this.validUser = false
      return
    }
    const username = this.formLogin.controls["username"].value
    const password = this.formLogin.controls["password"].value
    this.suscriptions.push(this._accountServ.login(username, password).subscribe({
      next: items => {
        this.loginResponse = items.response
        console.log(this.loginResponse.token)
      },
      error: (error: HttpErrorResponse) => {
        console.error(error.message)
      }
    }))
  }
}
