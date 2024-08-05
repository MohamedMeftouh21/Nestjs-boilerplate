import { Controller, Get, Param } from '@nestjs/common';
import { PostsService } from './posts.service';

@Controller('posts')
export class PostsController {
  constructor(private readonly postsservice: PostsService) {}

  @Get()
  findAll() {
    return this.postsservice.findAll();
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    try {
      const data = await this.postsservice.findOne(+id);
      return {
        success: true,
        data,
        message: 'User Fetched Successfully',
      };
    } catch (error) {
      return {
        success: false,
        message: error.message,
      };
    }
  }
}
