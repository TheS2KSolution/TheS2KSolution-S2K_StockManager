import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class CompteService {
  public compteUrl: any = environment.apiUrl+"/compte";

  constructor(private http: HttpClient) { }

  public getAllCompte(){
    return this.http.get(this.compteUrl+"/all");
  }
}
