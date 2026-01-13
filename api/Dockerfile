FROM public.ecr.aws/lambda/ruby:3.2

# Install dependencies (if any native extensions needed)
RUN yum install -y git make gcc

# Copy app
COPY . ${LAMBDA_TASK_ROOT}

# Install gems
COPY Gemfile Gemfile.lock ${LAMBDA_TASK_ROOT}/
RUN bundle config set --local path 'vendor/bundle' && \
    bundle install

# Set the CMD to your handler (could be also done as a parameter override outside of the Dockerfile)
CMD [ "lambda_handler.LambdaHandler.process" ]
