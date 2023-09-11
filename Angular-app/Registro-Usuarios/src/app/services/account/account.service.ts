import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { AccountLogin } from 'src/app/models/Account/account-model';

@Injectable({
  providedIn: 'root'
})
export class AccountService {

  constructor(private _http: HttpClient) { }

  login(username:string, password:string) : Observable<AccountLogin>{
    return this._http.post<AccountLogin>("https://localhost:44362/api/Account/Login", {
      "usuario": username,
      "contraseña": password
    })
  }
}
