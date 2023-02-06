class TestResult(object):
    """
    Results of baseline tests
    Representation of vresponsescore view
    """

    def __init__(
        self,
        user_id,  # noqa: E128
        module,
        course,
        test,
        test_date,
        score,
        testmaxscore,
        test_pass_score,
        passed,
        sort_order,
        channel_id,
    ):

        self.user_id = user_id
        self.module = module
        self.course = course
        self.test = test
        self.test_date = test_date
        self.score = score
        self.testmaxscore = testmaxscore
        self.test_pass_score = test_pass_score
        self.passed = passed
        self.sort_order = sort_order
        self.channel_id = channel_id

    def __str__(self):
        return "TestResult: user_id:{}, course:{}, module:{}, test:{}, passed:{}, sort_order: {}".format(
            self.user_id,
            self.course,
            self.module,
            self.test,
            self.passed,
            self.sort_order,
        )

    def __repr__(self):
        return "TestResult: user_id:{}, course:{}, module:{}, test:{}, passed:{}, sort_order: {}".format(
            self.user_id,
            self.course,
            self.module,
            self.test,
            self.passed,
            self.sort_order,
        )


class Course(object):
    """
    Configuration data for courses that have a baseline test.
    Representation of the course table
    """

    def __init__(self, module, course, sort_order, channel_id):
        self.module = module
        self.course = course
        self.sort_order = sort_order
        self.channel_id = channel_id

    def __str__(self):
        return "Course: name:{}, module:{}, sort_order:{}, channel_id:{}".format(
            self.course, self.module, self.sort_order, self.channel_id
        )

    def __repr__(self):
        return "Course: name:{}, module:{}, sort_order:{}, channel_id:{}".format(
            self.course, self.module, self.sort_order, self.channel_id
        )


class ChannelMeta(object):
    """
    Holds metadata about all existing Kolibri content databases that exist locally.
    Copied from kolibri.content.models.ChannelMetaData
    """

    def __init__(
        self,
        id,
        name,  # noqa: E128
        description,
        author,
        version,
        thumbnail,
        last_updated,
        min_schema_version,
        root,
        published_size,
        total_resource_count,
        included_languages,
        order,
    ):

        self.id = id
        self.name = name
        self.description = description
        self.author = author
        self.version = version
        self.thumbnail = thumbnail
        self.last_updated = last_updated
        self.min_schema_version = min_schema_version
        self.root = root
        self.published_size = published_size
        self.total_resource_count = total_resource_count
        self.included_languages = included_languages
        self.order = order

    def __str__(self):
        return self.name

    def __repr__(self):
        return self.name
