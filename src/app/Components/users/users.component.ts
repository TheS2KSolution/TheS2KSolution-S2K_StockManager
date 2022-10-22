import { Component, OnInit } from '@angular/core';
import { CompteService } from 'src/app/core/services/compte/compte.service';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css']
})
export class UsersComponent implements OnInit {

  constructor(private compteService: CompteService) { }

  ngOnInit(): void {
    this.compteService.getAllCompte().subscribe(
      {
        next: (listData) => {
          console.log(listData);
          
        },
        error: (error) => {
          console.log(error);
          
        }
      }
    )
  }

}
