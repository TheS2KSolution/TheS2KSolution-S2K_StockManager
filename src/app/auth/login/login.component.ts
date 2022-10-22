import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, UntypedFormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/core/services/auth/auth.service';

const TOKEN_KEY = 'auth-token';
const USER_KEY = 'auth-user';


@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  public loginForm!: FormGroup;

  constructor(
    private formBuilder: FormBuilder,
    private authService: AuthService,
    private router: Router) { }

  ngOnInit(): void {
    this.loginForm = this.formBuilder.group({
      usernameOrEmailOrPhone: ['', [Validators.required]],
      password: ['', [Validators.required]]
    });
  }

  loginUser()
  {
  
    this.authService.login(this.loginForm.value.usernameOrEmailOrPhone,
      this.loginForm.value.password).subscribe(
        {
          next:(_)=>{
            const accessToken = localStorage.getItem('accessToken');
            const refreshToken = localStorage.getItem('refreshToken');

            if(accessToken !== null && refreshToken !== null){
              this.router.navigate(['/users']);
            }
          },
          error:(error)=>{},
        }
      )    
    
  }
}
