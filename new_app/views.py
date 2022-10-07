from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.views import APIView
from rest_framework.response import Response
from .serializers import UserSerializer,RegisterSerializer
from django.contrib.auth.models import User
from rest_framework.authentication import TokenAuthentication
from rest_framework import generics

# Create your views here.

class UserDetailAPI(APIView):
  permission_classes = (IsAuthenticated,)
  def get(self,request,*args,**kwargs):
    user = User.objects.all()
    serializer = UserSerializer(user,many=True)
    return Response(serializer.data)
    

#Class based view to register user
class RegisterUserAPIView(generics.CreateAPIView):
  permission_classes = (AllowAny,)
  serializer_class = RegisterSerializer